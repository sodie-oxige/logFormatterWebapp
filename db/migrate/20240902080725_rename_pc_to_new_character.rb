class RenamePcToNewCharacter < ActiveRecord::Migration[7.2]
  def change
    rename_table :pcs, :characters
    add_column :characters, :is_pc, :boolean
  end
end
