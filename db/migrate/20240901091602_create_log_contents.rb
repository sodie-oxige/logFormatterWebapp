class CreateLogContents < ActiveRecord::Migration[7.2]
  def change
    create_table :log_contents do |t|
      t.references :log, null: false, foreign_key: true
      t.integer :index, null: false
      t.string :author, null: false
      t.string :color, null: false
      t.string :tab, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
