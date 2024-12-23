class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  enum :status, [ :pending, :ready ]

  validates :user_id, :subtotal, :total, presence: true

  # Method to check if the order includes a specific product
  def includes_product?(product)
    order_items.any? { |item| item.product_id == product.id }
  end

  # Method to calculate subtotal for a specific group of products
  def subtotal_for_group(group)
    group.products.map do |product|
      find_order_item_subtotal(product).to_f
    end.sum
  end

  def assign_cart_items(cart)
    cart.cart_items.each do |cart_item|
      order_items.build(product_id: cart_item.product_id, quantity: cart_item.quantity, subtotal: cart_item.subtotal)
    end
  end

  def find_order_item_subtotal(product)
    order_item = order_items.detect { |item| item.product_id == product.id }
    order_item.subtotal if order_item
  end

  def total_with_tax
    subtotal.to_f + total_tax.to_f
  end

  def total_amount
    order_items.sum do |order_item|
      item_total = order_item.unit_price * order_item.quantity
      item_total -= order_item.discount_amount # Apply any discounts
      item_total += order_item.tax_amount      # Add taxes
    end
  end

  def finalize_order
    order_items.each do |order_item|
      order_item.apply_free_item_logic
    end
    self.total_amount = total_amount
  end
end
