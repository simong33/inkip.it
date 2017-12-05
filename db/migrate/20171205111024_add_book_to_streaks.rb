class AddBookToStreaks < ActiveRecord::Migration[5.0]
  def change
    add_reference :streaks, :book, foreign_key: true
  end
end
