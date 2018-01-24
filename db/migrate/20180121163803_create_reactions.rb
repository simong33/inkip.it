class CreateReactions < ActiveRecord::Migration[5.0]
  def change
    create_table :reactions do |t|
      t.references :user, foreign_key: true
      t.references :chapter, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
