class CreateBids < ActiveRecord::Migration[5.2]
  def change
    create_table :bids do |t|
      t.integer :fixer_id
      t.integer :report_id
      t.integer :privacy
      t.string :description
      t.float :cost
      t.integer :marked
      t.integer :ignored

      t.timestamps
    end
  end
end
