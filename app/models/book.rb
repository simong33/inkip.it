class Book < ApplicationRecord
  belongs_to :user
  has_many :chapters, dependent: :destroy
  has_many :characters, dependent: :destroy
  has_many :places, dependent: :destroy
  has_many :streaks, dependent: :destroy
  has_many :daily_word_counts, dependent: :destroy
  has_many :reactions, through: :chapters

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
    self.chapters.each do |chapter|
      signs += chapter.signs unless chapter.content.nil?
    end
    signs
  end

  def wordcount
    words = 0
    self.chapters.each do |chapter|
      words += chapter.wordcount unless chapter.content.nil?
    end
    words
  end

  def word_goal_ratio
    if self.word_goal != nil && self.word_goal > 0
      self.wordcount.to_f / self.word_goal
    else
      0
    end
  end

  def average_daily_wordcount
    self.wordcount / self.age_in_days
  end

  def age_in_days
    ((Time.current - self.created_at) / (60*60*24)).floor
  end

  def words_per_session
    dwc_all = self.daily_word_counts.sort_by { |obj| obj.wordcount }.reverse!
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

    Book.where('max_streaks > 1').each do |book|
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
    books_ids = chapters.map(&:book_id)
    Book.find(books_ids)
  end

  def published?
    chapters.any? {|chapter| chapter.published == true}
  end

  def published_chapters
    chapters.where(published: true).order(:created_at)
  end

  def inks
    reactions.sum(&:inks)
  end

end
