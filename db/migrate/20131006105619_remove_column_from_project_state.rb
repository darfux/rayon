class RemoveColumnFromProjectState < ActiveRecord::Migration
  def change
    remove_column :project_states, :state, :string
  end
end
