class Review < ApplicationRecord
  resourcify
  belongs_to :product
  belongs_to :user
end
