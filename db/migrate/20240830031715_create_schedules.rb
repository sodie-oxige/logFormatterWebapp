class CreateSchedules < ActiveRecord::Migration[7.2]
  def change
    create_table :schedules do |t|
      t.references :session, null: false, foreign_key: true
      t.date :date, null: false
      t.integer :response, null: false

      t.timestamps
    end
  end
end
