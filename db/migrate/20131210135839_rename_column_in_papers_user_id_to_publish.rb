class RenameColumnInPapersUserIdToPublish < ActiveRecord::Migration
  def change
  	rename_column :papers, :user_id, :publish
  end
end
