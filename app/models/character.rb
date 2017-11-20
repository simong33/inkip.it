class Character < ApplicationRecord
  belongs_to :book
  has_many :appearances
  has_many :chapters, through: :appearances
  has_many :places, through: :appearances

  def name
    self.first_name + " " + self.last_name
  end
end
