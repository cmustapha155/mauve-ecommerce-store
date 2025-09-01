# class OrdersController < ApplicationController
#   before_action :initialize_cart

#   def create
#     @categories = Category.all

#     order = Order.new(
#       customer: current_customer,
#       email: params[:email],
#       address: params[:address],
#       city: params[:city],
#       state: params[:state],
#       zip: params[:zip],
#       country: params[:country]
#     )

#     @cart.each do |product_id, quantity|
#       product = Product.find(product_id)
#       order.order_items.build(
#         product: product,
#         quantity: quantity,
#         price: product.price
#       )
#     end

#     order.calculate_totals

#     if order.save
#       session[:cart] = {}  # clear cart
#       redirect_to order_path(order), notice: "Order placed successfully!"
#     else
#       redirect_to cart_path, alert: "Something went wrong, please try again."
#     end
#   end

#   def show
#     @categories = Category.all

#     @order = Order.find(params[:id])
#   end

#   def checkout
#     # This will automatically render app/views/orders/checkout.html.erb
#     # No additional code needed for a minimal form
#     @categories = Category.all
#   end


#   private def initialize_cart
#     @categories = Category.all

#     session[:cart] ||= {}
#     @cart = session[:cart]
#   end
# end









class OrdersController < ApplicationController
  before_action :initialize_cart

  # GET /checkout
  def checkout
    @categories = Category.all

    @order = Order.new

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

  # POST /orders
  def create
    @categories = Category.all

    order = Order.new(
      customer: current_customer,  # nil if guest
      email: params[:email],
      address: params[:address],
      apartment_number: params[:apartment_number],
      city: params[:city],
      state: params[:state],
      zip: params[:zip],
      country: params[:country],
      status: "new"
    )

    # Build OrderItems from session cart
    @cart.each do |product_id, quantity|
      product = Product.find(product_id)
      order.order_items.build(
        product: product,
        quantity: quantity,
        price: product.price  # snapshot at purchase
      )
    end

    order.calculate_totals

    if order.save
      session[:cart] = {}  # clear cart
      redirect_to order_path(order), notice: "Order placed successfully!"
    else
      flash.now[:alert] = "Something went wrong, please check your information."
      @order = order  # preserve entered info
      render :checkout
    end
  end

  # GET /orders/:id
  def show
    @categories = Category.all

    @order = Order.find(params[:id])
  end

  private def initialize_cart
    session[:cart] ||= {}
    @cart = session[:cart]
  end
end
