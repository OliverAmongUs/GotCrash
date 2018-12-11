class CreateForeignUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :foreign_users do |t|
      t.integer :user_id
      t.float :average_rating

      t.timestamps
    end
  end
end
