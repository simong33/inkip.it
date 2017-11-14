class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.string :name
      t.string :city
      t.string :country
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
