class ProductsSortingService
  def initialize(params, products = Product.all)
    @params = params
    @products = products
  end

  def sort_products

    if @params[:query].present?
      @products = @products.where("title ILIKE :query OR body ILIKE :query", query: "%#{@params[:query]}%")
    elsif @params[:first_last].present?
      @params[:first_last] == "first" ? @products = @products.first(5) : @products = @products.last(5)
    elsif @params[:sort_by_created_at].present?
      @params[:sort_by_created_at] == 'asc' ? @products = @products.order(created_at: :asc) : @products = @products.order(created_at: :desc)
    elsif @params[:sort_by_created_at].present?
      @params[:sort_by_updated_at] == 'asc' ? @products = @products.order(updated_at: :asc) : @products = @products.order(updated_at: :desc)
    end
    
  end
end