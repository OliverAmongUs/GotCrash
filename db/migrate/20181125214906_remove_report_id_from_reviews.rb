class RemoveReportIdFromReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :report_id, :integer
  end
end
