class AddColumnUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :appearanceMode, :integer
  end
end
