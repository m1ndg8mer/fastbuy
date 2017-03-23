class FixReferences < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :review_id
    add_column :reviews, :user_id, :integer
    add_column :reviews, :product_id, :integer
  end
end
