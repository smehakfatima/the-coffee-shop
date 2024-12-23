class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart = current_cart
    @cart_items = @cart.cart_items.includes(:product)
  end

  def destroy
    cart_item = CartItem.find_by_id(params[:id])
    cart_item.destroy!
    redirect_to cart_path, notice: 'cart item deleted successfully.'
  end
end
