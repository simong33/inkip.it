class Chapter < ApplicationRecord
  belongs_to :book
  has_many :appearances
  has_many :characters, through: :appearances
  has_many :places, through: :appearances

  def signs
    !self.content.nil? ? WordsCounted.count(self.strip_tags).char_count : 0
  end

  def strip_tags
    ActionView::Base.full_sanitizer.sanitize(self.content)
  end

  def wordcount
    self.signs > 0 ? WordsCounted.count(self.strip_tags).token_count : 0
  end
end
