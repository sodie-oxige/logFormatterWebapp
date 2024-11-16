class ChangeTextToCharacter < ActiveRecord::Migration[7.2]
  def change
      add_column :characters, :compressed_text, :binary
  end
end
