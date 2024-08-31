class CreateSessions < ActiveRecord::Migration[7.2]
  def change
    create_table :sessions do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
