class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :product_id, :quantity, :subtotal, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  def tax_amount
    taxes = product.tax_rates.map { |tax_rate| subtotal * tax_rate.rate / 100 }
    taxes.sum
  end

  def discount_amount
    discount = product.discounts.first
    return 0 unless discount
    
    if discount.discount_type == "percentage"
      unit_price * discount.value / 100
    else
      discount.value
    end
  end
end
