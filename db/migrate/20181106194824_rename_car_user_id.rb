class RenameCarUserId < ActiveRecord::Migration[5.2]
  def change
    remove_column :cars, :user_id, :integer
    add_column :cars, :owner_id, :integer
  end
end
