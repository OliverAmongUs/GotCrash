class CreateFixerJoinAutos < ActiveRecord::Migration[5.2]
  def change
    create_table :fixer_join_autos do |t|
      t.integer :fixer_id
      t.integer :auto_part_id

      t.timestamps
    end
  end
end
