class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :user

  default_scope { order(id: :desc) }
  enum status: [ :waiting_paid, :paid, :was_send, :close ]

end
