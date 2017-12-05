class AddMaxStreaksToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :max_streaks, :integer
  end
end
