class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  validate :user_cannot_follow_himself

  def user_cannot_follow_himself
    if followed_id == follower.id
      errors.add(:followed_id, "Vous ne pouvez pas vous suivre vous-même !")
    end
  end
end
