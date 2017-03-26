class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :cart
      t.references :user

      t.timestamps
    end
  end
end
