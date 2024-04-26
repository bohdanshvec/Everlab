class Admin::SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: :destroy
  
  def new
  end

  def create
    admin = Admin.find_by(email: params[:email])
    if admin&.authenticate(params[:password])
      sign_in(admin)
      flash[:success] = "Welcome back, #{admin.email}"
      redirect_to root_path
    else
      flash.now[:warning] = 'Incorrect email and/or password!'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sing_out
    flash[:success] = 'See yuo later!'
    redirect_to root_path
  end
end