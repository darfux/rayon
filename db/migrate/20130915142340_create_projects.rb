class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.integer :year
      t.string :type
      t.string :source

      t.timestamps
    end
  end
end
