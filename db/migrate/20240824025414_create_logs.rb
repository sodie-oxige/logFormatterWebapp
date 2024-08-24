class CreateLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :logs do |t|
      t.string :name
      t.date :date
      t.integer :gm

      t.timestamps
    end
  end
end
