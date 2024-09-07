class AddBookmarkToLogs < ActiveRecord::Migration[7.2]
  def change
    add_column :logs, :bookmark, :integer
  end
end
