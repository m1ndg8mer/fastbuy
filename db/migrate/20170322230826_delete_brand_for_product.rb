class DeleteBrandForProduct < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :brand
  end
end
