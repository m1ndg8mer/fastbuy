class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  default_scope { order(id: :desc) }

  def total_price
    (product.price * quantity).round(2)
  end
end
