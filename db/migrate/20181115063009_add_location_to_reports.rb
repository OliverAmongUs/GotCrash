class AddLocationToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :longitude, :float
    add_column :reports, :latitude, :float
  end
end
