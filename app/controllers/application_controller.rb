class ApplicationController < ActionController::Base
  include SessionsHelper
  private
    def logged_in_user
      unless logged_in?
          flash[:danger] = "新規登録、またはログインをしてください"
          redirect_to new_user_path
      end
    end
    
    def correct_user
      unless current_user == User.find(params[:id])
        redirect_to root_path
        flash[:danger] = "その機能はユーザー本人しか利用できません"
      end
    end
    
    def correct_post_user
      unless current_user == User.find_by(id: Post.find(params[:id]).user_id)
        redirect_to root_path
        flash[:danger] = "その機能はユーザー本人しか利用できません"
      end
    end
end
