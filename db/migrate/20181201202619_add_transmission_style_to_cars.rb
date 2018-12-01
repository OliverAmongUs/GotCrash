class AddTransmissionStyleToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :transmission_style, :string
  end
end
