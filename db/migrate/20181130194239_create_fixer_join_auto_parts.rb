class CreateFixerJoinAutoParts < ActiveRecord::Migration[5.2]
  def change
    create_table :fixer_join_auto_parts do |t|
      t.integer :fixer_id
      t.integer :AutoPart_id

      t.timestamps
    end
  end
end
