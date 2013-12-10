class CreateUserOwnTypes < ActiveRecord::Migration
  def change
    create_table :user_own_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
