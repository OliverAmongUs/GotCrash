class AddPictureUrlToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :picture_url, :string
  end
end
