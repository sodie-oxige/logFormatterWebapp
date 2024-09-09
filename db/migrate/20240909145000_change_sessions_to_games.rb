class ChangeSessionsToGames < ActiveRecord::Migration[7.2]
  def change
    rename_table :sessions, :games
    rename_column :schedules, :session_id, :game_id
  end
end
