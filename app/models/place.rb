class Place < ApplicationRecord
  belongs_to :book
  has_many :appearances
  has_many :chapters, through: :appearances
  has_many :characters, through: :appearances

  delegate :user, :to => :book, :allow_nil => true
end
