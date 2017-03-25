class Review < ApplicationRecord
  resourcify

  validates :review, presence: true
  validates_inclusion_of :rating, :in => 1..5

  default_scope { order(id: :desc) }

  belongs_to :product
  belongs_to :user
end
