class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.integer :owner_id
      t.integer :car_id
      t.integer :completed
      t.string :address
      t.string :description
      t.integer :privacy

      t.timestamps
    end
  end
end
