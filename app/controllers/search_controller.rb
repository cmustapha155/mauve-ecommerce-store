class SearchController < ApplicationController
  def index
    # @categories = Category.all
  end

  def search_results
    @categories = Category.all
    @keywords = params[:q].to_s.strip

    @products = Product.all.page(params[:page]).per(9).where("LOWER(name) LIKE LOWER(?) OR LOWER(description) LIKE LOWER(?)", "%#{@keywords}%", "%#{@keywords}%")
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end
  end
end
