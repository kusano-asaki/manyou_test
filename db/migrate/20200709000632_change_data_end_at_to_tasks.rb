class ChangeDataEndAtToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :end_at, :date
  end
end
