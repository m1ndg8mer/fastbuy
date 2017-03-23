class Product < ApplicationRecord
  resourcify
  validates :title, :qty, :price, :description, presence: true
  validates :qty, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price, format: { with: /\A\d+(?:\.\d{2})?\z/ }, numericality: { greater_than: 0.00 }

  has_attached_file :img, styles: { medium: "200x200>", thumb: "100x100>" },
                    default_url: ":style/missing.png"
  validates_attachment :img, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
                       size: { less_than: 1.megabytes }

  belongs_to :category
  has_many :reviews, :dependent => :destroy
end
