class DropTableRdusAndRdsus < ActiveRecord::Migration
  def change
  	drop_table :research_direction_users
  end
end
