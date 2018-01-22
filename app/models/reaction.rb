class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :chapter
  validates :user, presence: true
  validates :chapter, presence: true

  validates :user_id, :uniqueness => { :scope => :chapter_id }

  validates :inks, numericality: { less_than_or_equal_to: 50,  only_integer: true }

  attr_accessor :chapter_id

end
