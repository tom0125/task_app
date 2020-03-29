class AddNoteToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :note, :string
  end
end
