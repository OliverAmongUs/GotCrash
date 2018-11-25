class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    drop_table :messages
    create_table :messages do |t|
      t.string :body
      t.integer :user_id
      t.integer :bid_id
      t.string :picture_url

      t.timestamps
    end
  end
end
