class CreatePcs < ActiveRecord::Migration[7.2]
  def change
    create_table :pcs do |t|
      t.string :name
      t.integer :pl

      t.timestamps
    end
  end
end
