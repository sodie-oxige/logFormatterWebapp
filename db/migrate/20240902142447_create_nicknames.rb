class CreateNicknames < ActiveRecord::Migration[7.2]
  def change
    create_table :nicknames do |t|
      t.string :name
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
