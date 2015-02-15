class CreateResearchDirections < ActiveRecord::Migration
  def change
    create_table :research_directions do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
