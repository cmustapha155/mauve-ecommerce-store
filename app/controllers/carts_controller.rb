class CartsController < ApplicationController
  before_action :initialize_cart
  def show
    @categories = Category.all

    @cart_items = @cart.map do |product_id, quantity|
      product = Product.find_by(id: product_id)
      next unless product
      {
        product: product,
        quantity: quantity,
        subtotal: product.price * quantity
      }
    end.compact

    @total_price = @cart_items.sum { |item| item[:subtotal] }
  end

  def add
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i
    quantity = 1 if quantity <= 0

    @cart[product_id] ||= 0
    @cart[product_id] += quantity

    save_cart
    redirect_to cart_path, notice: "Added #{quantity} item(s) to cart."
  end

  def update
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i
    if quantity > 0
      @cart[product_id] = quantity
    else
      @cart.delete(product_id)
    end
    save_cart
    redirect_to cart_path, notice: "Cart updated."
  end

  def remove
    @cart.delete(params[:product_id].to_s)
    save_cart
    redirect_to cart_path, notice: "Item removed from cart."
  end

  private def initialize_cart
    # create cart variable and set to empty array unless it already exists
    session[:cart] = {} unless session[:cart]
    @cart = session[:cart]
  end

  private def save_cart
    session[:cart] = @cart
  end
end
