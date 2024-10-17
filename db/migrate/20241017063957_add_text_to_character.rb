class AddTextToCharacter < ActiveRecord::Migration[7.2]
  def change
    add_column :characters, :text, :text
  end
end
