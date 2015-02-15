class CreateTitles < ActiveRecord::Migration
  def change
    create_table :titles do |t|
      t.string :type

      t.timestamps
    end
  end
end
