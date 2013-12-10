class ChangeColumnTypeOfPublishInPaper < ActiveRecord::Migration
  def change
  	change_column :papers, :publish, :string
  end
end
