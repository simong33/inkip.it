class CreateDailyWordCounts < ActiveRecord::Migration[5.0]
  def change
    create_table :daily_word_counts do |t|
      t.integer :wordcount
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
