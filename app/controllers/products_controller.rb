class ProductsController < ApplicationController
  def index
    @products = Product.all
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])
    @categories = Category.all
  end
end
