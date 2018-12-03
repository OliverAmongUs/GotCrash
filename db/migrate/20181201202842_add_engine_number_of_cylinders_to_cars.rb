class AddEngineNumberOfCylindersToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :engine_number_of_cylinders, :string
  end
end
