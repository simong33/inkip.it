class AddWordGoalToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :word_goal, :integer
  end
end
