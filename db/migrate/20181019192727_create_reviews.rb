class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :fixer_id
      t.integer :report_id
      t.float :rating
      t.string :description

      t.timestamps
    end
  end
end
