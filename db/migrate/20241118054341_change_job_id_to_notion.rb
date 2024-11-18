class ChangeJobIdToNotion < ActiveRecord::Migration[8.0]
  def change
    add_index :notions, :job_id, unique: true
  end
end
