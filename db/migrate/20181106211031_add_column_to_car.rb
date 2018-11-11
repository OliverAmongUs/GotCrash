class AddColumnToCar < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :licence, :string
  end
end
