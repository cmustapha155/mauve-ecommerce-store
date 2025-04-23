class CategoriesController < ApplicationController
  def show
    @categories = Category.all
    @category = Category.find(params[:id])

    # the products, as a category knows it, is limited to the products with that category id
    @products = Product.where(category_id: @category)
  end
end
