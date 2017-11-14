class Book < ApplicationRecord
  belongs_to :user
  has_many :chapters
  has_many :characters
  has_many :places
end
