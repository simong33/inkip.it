class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :genre
      t.datetime :deadline
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
