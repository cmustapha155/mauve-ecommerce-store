class SearchController < ApplicationController
  def index
    # @categories = Category.all
  end

  def search_results
    @keywords = params[:q].to_s.strip
    @products = Product.all.page(params[:page]).per(9).where("LOWER(name) LIKE LOWER(?) OR LOWER(description) LIKE LOWER(?)", "%#{@keywords}%", "%#{@keywords}%")
    @categories = Category.all
  end
end
