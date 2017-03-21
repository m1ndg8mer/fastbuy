class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.integer :qty
      t.string :title
      t.float :price
      t.text :description

      t.references :review
      t.references :category
      t.timestamps

    end
  end
end
