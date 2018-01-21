class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :chapter
  validates :user, presence: true
  validates :chapter, presence: true

  validates :user_id, :uniqueness => { :scope => :chapter_id }

end
