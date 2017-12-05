class AddMaxDailyWordCountToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :max_daily_wordcount, :integer
  end
end
