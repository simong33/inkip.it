class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  has_many :books, dependent: :destroy
  has_many :chapters, through: :books
  has_many :characters, through: :books

  has_many :active_relationships, class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :reactions

  validates :user_name, uniqueness: true

  after_create :send_welcome_email

  has_attachment :profile_picture, accept: [:jpg, :png, :gif]

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.user_name = auth.info.first_name + " " + auth.info.last_name
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end

  def short_name
    if self.provider.nil?
      self.user_name
    else
      self.first_name
    end
  end

  def anonymise_name
    self.first_name + " " + self.last_name[0] + "."
  end

  def registered_name
    if self.user_name.nil? && self.provider.nil?
      self.first_name
    elsif self.provider == "facebook"
      self.anonymise_name
    else
      self.user_name
    end
  end

  def self.best_authors_max
    best_authors_max = []
    authors = []

    Book.includes(:user).best_max_dwc.each do |book|
      unless authors.include?(book.user)
        authors << book.user
        best_authors_max << [book.user, book.max_daily_wordcount]
      end
    end

    best_authors_max.take(10)
  end

  def self.best_authors_mean
    best_authors_mean = []
    authors = []

    Book.includes(:user).best_average_dwc.each do |array|
      unless authors.include?(array[0].user)
        authors << array[0].user
        best_authors_mean << [array[0].user, array[1]]
      end
    end

    best_authors_mean.take(10)
  end

  def self.most_consistent_authors
    most_consistent_authors = []
    authors = []

    Book.includes(:user).best_maximum_streaks.each do |book|
      unless authors.include?(book.user)
        authors << book.user
        most_consistent_authors << [book.user, book]
      end
    end

    most_consistent_authors.take(10)
  end

  def profile_picture_url

    if self.profile_picture
      pp = self.profile_picture
      "https://res.cloudinary.com/inkip-it/image/upload/" + "h_200/" + "q_60/" + "v1516284170/" + pp.public_id + "."+  pp.format
    elsif self.facebook_picture_url
      self.facebook_picture_url
    else
      ActionController::Base.helpers.asset_path("blank_profile.png")
    end

  end

  def has_written?
    books.present?
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def reacted_at?(chapter)
    reactions.any?{ |reaction| reaction.chapter == chapter }
  end

  def published_chapters
    chapters.where(published: true)
  end

  def published_books
    Book.where(user: self).includes(:chapters).select {|book| book.published? == true}
  end

  def has_published?
    books.any? {|book| book.published? == true}
  end

  def city
    if location && location.include?(",")
      location_split = location.split(/,\s*/)
      location_split[0] + ", " + location_split[2]
    else
      location
    end
  end

end
