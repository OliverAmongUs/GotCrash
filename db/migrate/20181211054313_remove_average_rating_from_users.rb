class RemoveAverageRatingFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :average_rating, :float
  end
end
