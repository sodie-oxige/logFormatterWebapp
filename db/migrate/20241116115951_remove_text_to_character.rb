class RemoveTextToCharacter < ActiveRecord::Migration[7.2]
  def up
    remove_column :characters, :text
  end

  def down
    add_column :characters, :text, :integer
  end
end
