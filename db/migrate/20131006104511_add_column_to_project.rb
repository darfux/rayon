class AddColumnToProject < ActiveRecord::Migration
  def change
    add_column :projects, :start, :date
    add_column :projects, :end, :date
    add_column :projects, :source_id, :integer
    add_column :projects, :project_state_id, :integer
    add_column :projects, :project_type_id, :integer
  end
end
