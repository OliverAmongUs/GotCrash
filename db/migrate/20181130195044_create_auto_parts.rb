class CreateAutoParts < ActiveRecord::Migration[5.2]
  def change
    create_table :auto_parts do |t|
      t.string :type
      t.string :name

      t.timestamps
    end
  end
end
