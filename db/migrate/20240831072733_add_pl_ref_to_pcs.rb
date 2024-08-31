class AddPlRefToPcs < ActiveRecord::Migration[7.2]
  def change
    remove_column :pcs, :pl, :integer
    add_reference :pcs, :pl, null: false, foreign_key: true
    remove_column :appear_pcs, :pc, :integer
    add_reference :appear_pcs, :pc, null: false, foreign_key: true
    remove_column :appear_pcs, :log_id, :integer
    add_reference :appear_pcs, :log, null: false, foreign_key: true
    remove_column :logs, :gm, :integer
    add_reference :logs, :pl, null: false, foreign_key: true
  end
end
