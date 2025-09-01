# class OrdersController < ApplicationController
#   before_action :initialize_cart

#   # GET /checkout
#   def checkout
#     @categories = Category.all

#     @order = Order.new

#     @cart_items = @cart.map do |product_id, quantity|
#       product = Product.find_by(id: product_id)
#       next unless product
#       {
#         product: product,
#         quantity: quantity,
#         subtotal: product.price * quantity
#       }
#     end.compact

#     @total_price = @cart_items.sum { |item| item[:subtotal] }
#   end

#   # POST /orders
#   def create
#     @categories = Category.all


#     @order = Order.new(
#       customer: current_customer,  # nil if guest
#       email: params[:email],
#       address: params[:address],
#       apartment_number: params[:apartment_number],
#       city: params[:city],
#       state: params[:state],
#       zip: params[:zip],
#       country: params[:country],
#       status: "new"
#     )

#     @order.subtotal = session[:cart_subtotal] || 0
#     @order.calculate_totals

#     # Build OrderItems from session cart
#     @cart.each do |product_id, quantity|
#       product = Product.find(product_id)
#       @order.order_items.build(
#         product: product,
#         quantity: quantity,
#         price: product.price  # snapshot at purchase
#       )
#     end

#     # @order.calculate_totals

#     if @order.save
#       session[:cart] = {}  # clear cart
#       # session[:cart_subtotal] = 0
#       redirect_to order_path(@order), notice: "Order placed successfully!"
#     else
#       flash.now[:alert] = "Something went wrong, please check your information."
#       # @order = order  # preserve entered info
#       render :checkout
#     end
#   end

#   # GET /orders/:id
#   def show
#     @categories = Category.all

#     @order = Order.find(params[:id])
#   end

#   private def initialize_cart
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

    # Build cart items only if you want to display them
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
    @general_tax_rate = 0.05
    @provincial_tax_rates = {
      "AB" => 0.00,
      "BC" => 0.07,
      "MB" => 0.07,
      "NB" => 0.10,
      "NL" => 0.10,
      "NS" => 0.10,
      "NT" => 0.00,
      "NU" => 0.00,
      "ON" => 0.08,
      "PE" => 0.10,
      "QC" => 0.09975,
      "SK" => 0.06,
      "YT" => 0.00
    }

    @order = Order.new(
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

    @cart_items = @cart.map do |product_id, quantity|
      product = Product.find_by(id: product_id)
      next unless product
      {
        product: product,
        quantity: quantity,
        subtotal: product.price * quantity
      }
    end.compact

    # SUBTOTAL
    @order.subtotal = @cart_items.sum { |item| item[:subtotal] }
    # @order.provincial_sales_tax = 0
    # @order.general_sales_tax = 0

    # TAXES
    province_rate = @provincial_tax_rates[@order.state] || 0
    @order.provincial_sales_tax = (@order.subtotal * province_rate).round(2)
    @order.general_sales_tax = (@order.subtotal * @general_tax_rate).round(2)

    ## GRAND TOTAL
    @order.total_price = @order.subtotal + @order.provincial_sales_tax + @order.general_sales_tax


    if @order.save
      session[:cart] = {}  # clear cart
      session[:cart_subtotal] = 0
      redirect_to order_path(@order), notice: "Order placed successfully!"
    else
      flash.now[:alert] = "Something went wrong, please check your information."
      render :checkout
    end
  end

  # GET /orders/:id
  def show
    @categories = Category.all
    @order = Order.find(params[:id])
  end

  private

  def initialize_cart
    session[:cart] ||= {}
    @cart = session[:cart]
  end
end
