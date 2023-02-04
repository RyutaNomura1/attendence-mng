class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.post_id = params[:post_id]
    if @comment.save
      redirect_back(fallback_location: root_path)
      flash[:success] = "コメントを投稿しました"
    else
      redirect_back(fallback_location: root_path)
      flash[:danger]= "コメントの投稿に失敗しました"
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "コメントを削除しました"
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment_body,)
  end
  
end
