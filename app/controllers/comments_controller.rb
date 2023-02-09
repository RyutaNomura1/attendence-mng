class CommentsController < ApplicationController
  before_action :define_post
  def create
    comment = current_user.comments.build(comment_params)
    comment.post_id = params[:post_id]
    comment.save
  end
  
  def destroy
    comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    comment.destroy
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment_body,)
  end
  
  # ajax処理で呼び出すテンプレートに必要な@postの定義
  def define_post
    @post = Post.find(params[:post_id])
  end
end
