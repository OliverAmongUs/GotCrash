class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.integer :owner_id
      t.string :make
      t.string :model
      t.string :year
      t.string :color
      t.string :vin

      t.timestamps
    end
  end
end
