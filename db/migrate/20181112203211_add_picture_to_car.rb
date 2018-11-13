class AddPictureToCar < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :picture_url, :string
  end
end
