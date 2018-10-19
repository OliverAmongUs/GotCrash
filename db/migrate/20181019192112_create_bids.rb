class CreateBids < ActiveRecord::Migration[5.2]
  def change
    create_table :bids do |t|
      t.integer :user_id
      t.integer :case_id
      t.integer :privacy
      t.string :description
      t.float :cost
      t.integer :marked
      t.integer :ignored

      t.timestamps
    end
  end
end
