class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :comment_params , :only =>[:create , :update]
  before_action :comment_id_params, :only =>[:destroy]
  before_action :set_comment , :only =>[:destroy]
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to article_path(comment_params['article_id'])
  end

  def destroy
    if @comment.user_id == current_user.id
      @comment.delete
      flash[:notice] ='已刪除留言'
    else
      flash[:notice] ='不能刪除他人的留言'
    end
    redirect_to :back
  end

  private
  def set_comment
    @comment = Comment.find(@comment_id['id'])
  end
  def comment_params
    params.require(:comment).permit(:content , :article_id)
  end
  def comment_id_params
    @comment_id = params.require(:comment).permit(:id)
  end
end
