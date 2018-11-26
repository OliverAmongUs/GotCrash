class RemoveBidIdFromReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :bid_id, :integer
  end
end
