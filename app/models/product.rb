class Product < ApplicationRecord
  resourcify
  validates :title, :qty, :price, :description, presence: true
  validates :qty, presence: true, numericality: { only_integer: true, greater_than: -1 }
  validates :price, format: { with: /\A\d+(?:\.\d{2})?\z/ }, numericality: { greater_than: 0.00 }

  default_scope { order(id: :desc) }
  scope :similar, -> (cat_id) { where(category_id: cat_id).limit(4) }

  before_destroy :ensure_not_referenced_by_any_line_item

  has_attached_file :img, styles: { medium: "200x200>", thumb: "100x100>" },
                    default_url: ":style/missing.png"
  validates_attachment :img, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
                       size: { less_than: 1.megabytes }

  belongs_to :category
  has_many :reviews, :dependent => :destroy
  has_many :line_items

  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add('Isset product line!')
      return false
    end
  end

end
