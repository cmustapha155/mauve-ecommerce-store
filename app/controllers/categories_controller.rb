class CategoriesController < ApplicationController
  def show
    @categories = Category.all
    @products = Product.all
  end
end
