class Order < ApplicationRecord
  belongs_to :customer, optional: true

  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :status, presence: true
  validates :subtotal, :provincial_sales_tax, :general_sales_tax, :total_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # Helper to calculate totals from associated OrderItems
  def calculate_totals
    self.subtotal = order_items.sum { |item| item.price * item.quantity }
    self.total_price = subtotal + (provincial_sales_tax || 0) + (general_sales_tax || 0)
  end
end
