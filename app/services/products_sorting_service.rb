class ProductsSortingService
  def initialize(params)
    @params = params
  end

  def sort_products
    str = 'Product'

    if @params[:query].present?
      str = 'Product.where("title ILIKE :query OR body ILIKE :query", query: "%#{@params[:query]}%")'
    end

    if @params[:first_last].present?
      str = str + "#{@params[:first_last]}"
    elsif @params[:sort_by_created_at].present? || @params[:sort_by_updated_at].present?
      str = str + ".order(#{@params[:sort_by_created_at] || @params[:sort_by_updated_at]})"
    elsif @params[:first_last].present? && (@params[:sort_by_created_at].present? || @params[:sort_by_updated_at].present? )
      str = str + ".order(#{@params[:sort_by_created_at] || @params[:sort_by_updated_at]})#{@params[:first_last]}"
    elsif @params[:sort_by_created_at].present? && @params[:sort_by_updated_at].present? && @params[:first_last]
      str = str + ".order(#{@params[:sort_by_created_at]}, #{@params[:sort_by_updated_at]})#{@params[:first_last]}"
    else
      str = str + ".all"
    end

    products = eval(str)
    products
  end
end