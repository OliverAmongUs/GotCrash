class AddBidIdToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :bid_id, :integer
  end
end
