class Chapter < ApplicationRecord
  belongs_to :book
  has_many :appearances
  has_many :characters, through: :appearances
  has_many :places, through: :appearances

  after_save :create_streak, :count_current_streak, :count_today_wordcount, :set_max_dwc

  def signs
    !self.content.nil? ? WordsCounted.count(self.strip_tags).char_count : 0
  end

  def strip_tags
    ActionView::Base.full_sanitizer.sanitize(self.content)
  end

  def wordcount
    self.signs > 0 ? WordsCounted.count(self.strip_tags).token_count : 0
  end

  def create_streak
    book = self.book
    unless book.streaks.empty?
      book.streaks.each do |streak|
        if streak.created_at.today?
          break
        else
          streak = Streak.new(book: book)
          streak.save
        end
      end
    else
      streak = Streak.new(book: book)
      streak.save
    end
  end

  def count_current_streak
    streaks = determine_consecutive_days
    book = self.book
    book.current_streaks = streaks
    book.save

    if (book.max_streaks != nil && book.current_streaks > book.max_streaks) || book.max_streaks.nil?
      book.max_streaks = book.current_streaks
      book.save
    end
  end

  def count_today_wordcount
    book = self.book
    count = 0

    unless book.daily_word_counts.empty?
      book.daily_word_counts.each do |dwc|
        if dwc.created_at.today?
          dwc.wordcount = book.wordcount
          dwc.save
          count += 1
        end
      end
      if count == 0
        daily_wordcount = DailyWordCount.new(book: book, wordcount: book.wordcount)
        daily_wordcount.save
      end
    else
      daily_wordcount = DailyWordCount.new(book: book, wordcount: book.wordcount)
      daily_wordcount.save
    end
  end

  def set_max_dwc
    book = self.book

    unless book.daily_word_counts.nil?
      book.daily_word_counts.each do |dwc|
        if ( !book.max_daily_wordcount.nil? && dwc.wordcount > book.max_daily_wordcount) || book.max_daily_wordcount.nil?
          book.max_daily_wordcount = dwc.wordcount
          book.save
        end
      end
    else
      book.max_daily_wordcount = dwc.wordcount
      book.save
    end

  end

  private

  # https://github.com/garrettqmartin8/has_streak/blob/master/lib/has_streak/streak.rb

  def days
    @days ||= self.book.streaks.order("created_at DESC").pluck(:created_at).map(&:to_date).uniq
  end

  def determine_consecutive_days
    streak = first_day_in_collection_is_today? ? 1 : 0
    days.each_with_index do |day, index|
      break unless first_day_in_collection_is_today?
      if days[index+1] == day.yesterday
        streak += 1
      else
        break
      end
    end
    streak
  end

  def first_day_in_collection_is_today?
    days.first == Date.current
  end

end
