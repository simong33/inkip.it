class RenameValueinReactiontoInks < ActiveRecord::Migration[5.0]
  def change
    rename_column :reactions, :value, :inks
  end
end
