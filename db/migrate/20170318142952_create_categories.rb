class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.integer :parent_id
      t.string :title
      t.timestamps
    end
  end
end
