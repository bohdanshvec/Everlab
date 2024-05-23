class Admin::ProductsController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :require_authentication, only: %i[new create edit update destroy]
  before_action :set_product!, only: %i[edit update destroy]

  def index
    if params.except(:controller, :action).present? && Product.reprocessing_request == nil
      @products = ProductsSortingService.new(params).sort_products
      Product.reprocessing_request = @products
    elsif params.except(:controller, :action).present? && Product.reprocessing_request.present?
      @products = ProductsSortingService.new(params, Product.reprocessing_request).sort_products
    else
      @products = Product.all.ordered
      Product.reprocessing_request = nil
    end
    @comment = Comment.new
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:success] = "You created new product"
      redirect_to root_path
      # respond_to do |format|
      #   format.html { redirect_to root_path, notice: "Product was successfully created." }
        # format.turbo_stream
      # end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      flash[:success] = "You updated product"
      redirect_to root_path(anchor: dom_id(@product))
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.comments.destroy_all
    @product.destroy
    flash[:success] = "Product deleted"
    redirect_to root_path, status: :see_other
  end

  private

  def parameters_in_previous_request
    params.except(:controller, :action)
  end

  def set_product!
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :body, :position)
  end
end