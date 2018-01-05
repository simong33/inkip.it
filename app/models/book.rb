class Book < ApplicationRecord
  belongs_to :user
  has_many :chapters, dependent: :destroy
  has_many :characters, dependent: :destroy
  has_many :places, dependent: :destroy
  has_many :streaks, dependent: :destroy
  has_many :daily_word_counts, dependent: :destroy

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
    chapters = self.chapters
    dwc_all = self.daily_word_counts

    unless chapters.empty? || dwc_all.empty?
      words_per_session = self.wordcount / dwc_all.count
    else
      words_per_session = 0
    end
  end

  def self.most_written_books
    Book.where('max_daily_wordcount > 0').order(max_daily_wordcount: :desc).limit(10)
  end

  def self.best_average_dwc
    books_average_dwc = []

    Book.all.each do |book|
      books_average_dwc << [book, book.words_per_session]
    end

    books_average_dwc_sorted = books_average_dwc.sort {|a, b| b[1] <=> a[1]}

    books_average_dwc = books_average_dwc_sorted.take(10)
  end

end
