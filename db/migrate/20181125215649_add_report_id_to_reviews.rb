class AddReportIdToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :report_id, :integer
  end
end
