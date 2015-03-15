class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.text :detail

      t.timestamps
    end
  end
end
