class Admin::CommentsController < ApplicationController

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.build(comment_params)

    if @comment.save
      flash[:success] = 'You created comment for product'
      redirect_to root_path
    else
      # flash[:warning] = 'Comment not created'
      # flash.now[:warning] = 'Comment not created due to validation errors.'
      render 'admin/products/show', status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end