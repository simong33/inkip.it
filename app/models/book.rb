class Book < ApplicationRecord
  belongs_to :user
  has_many :chapters, dependent: :destroy
  has_many :characters, dependent: :destroy
  has_many :places, dependent: :destroy
  has_many :streaks, dependent: :destroy
  has_many :daily_word_counts, dependent: :destroy
  has_many :reactions, through: :chapters

  scope :find_lazy, ->(id) { where(id: id) }

  validate do |book|
    book.errors.add(:base, "Ajoutez un titre à votre livre ! Vous pourrez le modifier par la suite.") if book.title.blank?
  end

  after_create :init

  def init
    self.max_streaks ||= 0
    self.current_streaks ||= 0
    self.max_daily_wordcount ||= 0
  end

  def signs
    signs = 0
    chapters.each do |chapter|
      signs += chapter.signs unless chapter.content.nil?
    end
    signs
  end

  def wordcount
    words = 0
    chapters.each do |chapter|
      words += chapter.wordcount unless chapter.content.nil?
    end
    words
  end

  def word_goal_ratio
    if word_goal != nil && word_goal > 0
      wordcount.to_f / word_goal
    else
      0
    end
  end

  def average_daily_wordcount
    wordcount / age_in_days
  end

  def age_in_days
    ((Time.current - created_at) / (60*60*24)).floor
  end

  def words_per_session
    dwc_all = daily_word_counts.sort_by { |obj| obj.wordcount }.reverse!
    dwc_all.shift

    dwc_wordcount = 0

    dwc_all.each do |dwc|
      dwc_wordcount += dwc.wordcount
    end

    unless chapters.empty? || dwc_all.empty?
      words_per_session = dwc_wordcount / dwc_all.count
    else
      words_per_session = 0
    end
  end

  def self.best_max_dwc
    Book.where('max_streaks > 1 & max_daily_wordcount IS NOT NULL').order(max_daily_wordcount: :desc)
  end

  def self.best_average_dwc
    books_average_dwc = []

    Book.where('max_streaks > 1').includes(:daily_word_counts, :chapters).each do |book|
      books_average_dwc << [book, book.words_per_session]
    end

    books_average_dwc_sorted = books_average_dwc.sort {|a, b| b[1] <=> a[1]}
  end

  def self.best_maximum_streaks
    Book.where.not(max_streaks: nil).order(max_streaks: :desc)
  end

  def self.published
    chapters = Chapter.published.sort_by &:updated_at
    chapters.reverse!
    books_ids = chapters.pluck(:book_id)
    Book.find_lazy(books_ids)
  end

  def published?
    chapters.any? {|chapter| chapter.published == true}
  end

  def published_chapters
    Chapter.where(published: true, book: self).order(:created_at)
  end

  def inks
    published_chapters.includes(:reactions).sum(&:inks)
  end

  def self.published_popular
    books = Book.published.limit(10)
    books.sort { |x, y| y.inks <=> x.inks }
  end

  def is_completed?
    word_goal_ratio >= 1
  end

  def self.authored_by_followers_of(user)
    following = user.following
    books = []

    Book.includes(:user).where(user: following).each do |book|
      books << book if book.published?
    end
    books
  end

  def last_month_daily_word_counts
    daily_word_counts.order('created_at').last(30)
  end

  def last_year_daily_word_counts
    daily_word_counts.order('created_at').last(365)
  end

  def daily_word_counts_info
    dwc_dates = []
    dwc_values = []
    dwc_total_values = []

    last_month_daily_word_counts.each do |dwc|
      dwc_dates << dwc.created_at.strftime('%d/%m/%Y')
      dwc_values << dwc.wordcount
      dwc_total_values << dwc.total_word_count
    end

    [dwc_dates, dwc_values, dwc_total_values]
  end

  def words_left
    word_goal - wordcount if word_goal
  end

  def daily_word_counts_calendar
    dwc_map = last_year_daily_word_counts.map {|dwc| [dwc.created_at.to_datetime.strftime('%s'), dwc.wordcount]}
    Hash[dwc_map]
  end

  def global_words_per_session
    all_dwc = DailyWordCount.where('wordcount < 10000')
    dwc = last_month_daily_word_counts

    all_dwc_size = 0

    all_dwc.each do |dwc|
      all_dwc_size += dwc.wordcount unless dwc.wordcount.nil? || dwc.wordcount > 10000
    end

    (all_dwc_size / all_dwc.count) unless all_dwc.count == 0
  end

end
