class CreateResearchDirectionUsers < ActiveRecord::Migration
  def change
    create_table :research_direction_users do |t|
      t.integer :research_direction_id
      t.integer :user_id

      t.timestamps
    end
  end
end
