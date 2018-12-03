class AddGrossVehicleWeightRatingToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :gross_vehicle_weight_rating, :string
  end
end
