class AddEnginePowerToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :engine_power, :string
  end
end
