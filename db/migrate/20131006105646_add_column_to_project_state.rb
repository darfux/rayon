class AddColumnToProjectState < ActiveRecord::Migration
  def change
    add_column :project_states, :name, :string
  end
end
