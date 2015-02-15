class CreatePaperUsers < ActiveRecord::Migration
  def change
    create_table :paper_users do |t|
      t.integer :paper_id
      t.integer :user_id
      t.integer :own_type_id

      t.timestamps
    end
  end
end
