class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :title_id, :integer
  end
end
