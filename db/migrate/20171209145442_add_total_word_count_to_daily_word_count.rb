class AddTotalWordCountToDailyWordCount < ActiveRecord::Migration[5.0]
  def change
    add_column :daily_word_counts, :total_word_count, :integer
  end
end
