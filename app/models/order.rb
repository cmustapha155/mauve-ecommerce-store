class Order < ApplicationRecord
  belongs_to :customer, optional: true

  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :status, presence: true
  validates :subtotal, :provincial_sales_tax, :general_sales_tax, :total_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  def provincial_tax_rate
    PROVINCIAL_TAX_RATES[state] || 0
  end

  # Helper to calculate totals from associated OrderItems
  def calculate_totals
    self.provincial_sales_tax = subtotal * provincial_tax_rate
    self.general_sales_tax = subtotal * GENERAL_TAX_RATE
    self.total_price = subtotal + (provincial_sales_tax || 0) + (general_sales_tax || 0)
  end
end
