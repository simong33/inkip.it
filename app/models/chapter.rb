class Chapter < ApplicationRecord
  belongs_to :book
  has_many :appearances
  has_many :characters, through: :appearances
  has_many :places, through: :appearances

  after_save :create_streak, :count_current_streak

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
    unless self.book.streaks.empty?
      self.book.streaks.each do |streak|
        if streak.created_at.today?
          break
        else
          streak = Streak.new(book: self.book)
          streak.save
        end
      end
    else
      streak = Streak.new(book: self.book)
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
