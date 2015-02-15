class RenameColumnInPapaerUsers < ActiveRecord::Migration
  def change
  	rename_column :paper_users, :own_type_id, :user_own_type_id
  end
end
