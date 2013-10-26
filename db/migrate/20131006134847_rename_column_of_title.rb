class RenameColumnOfTitle < ActiveRecord::Migration
  def change
  	rename_column :titles, :type, :name
  end
end
