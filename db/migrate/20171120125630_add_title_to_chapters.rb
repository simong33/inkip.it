class AddTitleToChapters < ActiveRecord::Migration[5.0]
  def change
    add_column :chapters, :title, :string
  end
end
