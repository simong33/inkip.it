class AddPlaceToAppearances < ActiveRecord::Migration[5.0]
  def change
    add_reference :appearances, :place, foreign_key: true
  end
end
