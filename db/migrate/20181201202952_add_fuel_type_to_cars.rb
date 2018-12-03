class AddFuelTypeToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :fuel_type, :string
  end
end
