class Chapter < ApplicationRecord
  belongs_to :book
  has_many :appearances
  has_many :characters, through: :appearances
  has_many :places, through: :appearances

  def signs
    self.content.size
  end

  def wordcount
    self.content.scan(/[[:alpha:]]+/).count
  end
end
