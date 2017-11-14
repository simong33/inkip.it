class Appearance < ApplicationRecord
  belongs_to :chapter
  belongs_to :character
  belongs_to :place
end
