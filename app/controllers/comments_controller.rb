class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
      flash[:danger]= "コメントの投稿に失敗しました"
    end
  end
  
  def destroy
    
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment_body, :post_id)
  end
  
end
