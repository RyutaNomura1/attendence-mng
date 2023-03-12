class ApplicationController < ActionController::Base
  include SessionsHelper
  private
    def logged_in_user
      unless logged_in?
          flash[:danger] = "新規登録、またはログインをしてください"
          redirect_to new_user_path
      end
    end
    
    def logged_in_user_for_root
      unless  logged_in?
        # フラッシュメッセージを表示しない
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
      post = Post.find(params[:id])
      unless current_user == post.user
        redirect_to root_path
        flash[:danger] = "その機能はユーザー本人しか利用できません"
      end
    end
    
    def correct_question_user
      question = Question.find(params[:id])
      unless current_user == question.user
        redirect_to root_path
        flash[:danger] = "その機能はユーザー本人しか利用できません"
      end
    end    

    def correct_answer_user
      answer = Answer.find(params[:id])
      unless current_user == answer.user
        redirect_to root_path
        flash[:danger] = "その機能はユーザー本人しか利用できません"
      end
    end    
end
