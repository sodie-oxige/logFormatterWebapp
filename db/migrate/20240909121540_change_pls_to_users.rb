class ChangePlsToUsers < ActiveRecord::Migration[7.2]
  def change
    rename_table :pls, :users
    add_column :users, :userid, :string
    add_column :users, :password_digest, :string
    rename_column :logs, :pl_id, :gm_id
  end
end
