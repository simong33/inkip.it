class AddCurrentStreaksToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :current_streaks, :integer
  end
end
