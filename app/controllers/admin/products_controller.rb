class Admin::ProductsController < ApplicationController
  before_action :require_authentication, only: %i[new create]

  def index
    # byebug
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
  end
end