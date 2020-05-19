class AddColumnsToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :description, :string
    add_column :categories, :image, :string
  end
end
