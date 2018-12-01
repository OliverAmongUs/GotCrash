class AddVehicleTypeToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :vehicle_type, :string
  end
end
