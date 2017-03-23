class Category < ApplicationRecord
  resourcify

  validates :title, presence: true

  default_scope { order(id: :desc) }
  scope :sub, -> { where('parent_id IS NOT NULL') }

  has_many :subcategories, :class_name => 'Category', :foreign_key => :parent_id, :dependent => :destroy
  has_one :parent, :class_name => 'Category', :primary_key => :parent_id, :foreign_key => :id
  has_many :products, :dependent => :destroy
end
