class CreateReportJoinAutos < ActiveRecord::Migration[5.2]
  def change
    create_table :report_join_autos do |t|
      t.integer :report_id
      t.integer :auto_part_id

      t.timestamps
    end
  end
end
