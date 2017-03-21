class Product < ApplicationRecord
  resourcify
  belongs_to :category
  has_many :reviews
end
