class ChangeColomnOfReports < ActiveRecord::Migration[5.2]
  def change
    remove_column :reports, :user_id, :integer
    add_column :reports, :owner_id, :integer
  end
end
