class AddUnitToUser < ActiveRecord::Migration
  def change
    add_reference :users, :unit
  end
end
