class CreateResearchDirectionsUsers < ActiveRecord::Migration
  def change
    create_table :research_directions_users do |t|
      t.integer :user_id
      t.integer :research_direction_id

      t.timestamps
    end
  end
end
