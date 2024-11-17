class CreateNotions < ActiveRecord::Migration[8.0]
  def change
    create_table :notions do |t|
      t.string :job_id, null: false
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :progress, null: false
      t.integer :max, null: false

      t.timestamps
    end
  end
end
