class RemoveBookmarkFromLogs < ActiveRecord::Migration[7.2]
  def up
    remove_column :logs, :bookmark
  end

  def down
    add_column :logs, :bookmark, :integer
  end
end
