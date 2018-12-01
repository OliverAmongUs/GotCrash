class AddBodyClassToCars < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :body_class, :string
  end
end
