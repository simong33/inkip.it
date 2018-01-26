class AddIndexToChapters < ActiveRecord::Migration[5.0]
  def change
    add_index(:chapters, :published)
  end
end
