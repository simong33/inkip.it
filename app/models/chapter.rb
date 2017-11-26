class Chapter < ApplicationRecord
  belongs_to :book
  has_many :appearances
  has_many :characters, through: :appearances
  has_many :places, through: :appearances

  def signs
    self.content.nil? ? 0 : self.content.size
  end

  def wordcount
    self.signs > 0 ? self.content.scan(/[[:alpha:]]+/).count : 0
  end
end
