class AddPublicationToChapters < ActiveRecord::Migration[5.0]
  def change
    add_column :chapters, :published, :boolean
    add_column :chapters, :published_at, :datetime
    add_column :chapters, :edited_at, :datetime
  end
end
