class ProductModel < ApplicationRecord
  belongs_to :supplier
  has_many :order_items
  has_many :orders, through: :order_items
  
  validates :name, :wight, :width, :height, :depth, :supplier, :sku, presence: true
  validates :width, :wight, :height, :depth, numericality: { greater_than: 0 }
  validates :sku, length: { is: 20 }
  validates :sku, uniqueness: true
end
