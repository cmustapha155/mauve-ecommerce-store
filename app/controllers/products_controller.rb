class ProductsController < ApplicationController
  def index
    @products = Product.all.page(params[:page]).per(9)
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])
    @categories = Category.all
  end
end
