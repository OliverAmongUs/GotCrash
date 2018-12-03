class CreateAutoParts < ActiveRecord::Migration[5.2]
  def change
    create_table :auto_parts do |t|
      t.string :field
      t.string :name

      t.timestamps
    end
  end
end
