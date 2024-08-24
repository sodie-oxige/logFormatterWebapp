class CreateAppearPcs < ActiveRecord::Migration[7.2]
  def change
    create_table :appear_pcs do |t|
      t.integer :log_id
      t.integer :pc

      t.timestamps
    end
  end
end
