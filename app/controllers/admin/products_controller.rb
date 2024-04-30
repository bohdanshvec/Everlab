class Admin::ProductsController < ApplicationController
  before_action :require_authentication, only: %i[new create edit update destroy]
  before_action :set_product!, only: %i[edit update destroy]

  def index
    # byebug
    @products = ProductsSortingService.new(params).sort_products
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:success] = "You created new product"
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      flash[:success] = "You updated product"
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.delete
    flash[:success] = "Product deleted"
    redirect_to root_path, status: :see_other
  end

  private

  def set_product!
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :body, :position)
  end
end