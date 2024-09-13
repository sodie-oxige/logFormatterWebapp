class AddHiddenToLogs < ActiveRecord::Migration[7.2]
  def change
    add_column :logs, :hidden, :boolean
  end
end
