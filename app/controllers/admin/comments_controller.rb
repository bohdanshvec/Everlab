class Admin::CommentsController < ApplicationController
  
  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.build(comment_params)

    if @comment.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'You created comment for product' }
        format.turbo_stream
      end
      # flash[:success] = 'You created comment for product'
      # redirect_to root_path
    else
      # flash[:warning] = 'Comment not created'
      render partial: 'admin/comments/form', status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end