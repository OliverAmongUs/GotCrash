class CreateReportJoinAutoParts < ActiveRecord::Migration[5.2]
  def change
    create_table :report_join_auto_parts do |t|
      t.integer :report_id
      t.integer :AutoPart_id

      t.timestamps
    end
  end
end
