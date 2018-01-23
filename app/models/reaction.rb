class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :chapter

  delegate :book, :to => :chapter, :allow_nil => true

  validates :user, presence: true
  validates :chapter, presence: true

  validates :user_id, :uniqueness => { :scope => :chapter_id }

  validates :inks, numericality: { less_than_or_equal_to: 50,  only_integer: true }

  validate :user_cannot_react_to_himself

  attr_accessor :chapter_id

  def user_cannot_react_to_himself
    if user == chapter.user
      errors.add(:user, "Vous ne pouvez pas vous donner des inks !")
    end
  end

end
