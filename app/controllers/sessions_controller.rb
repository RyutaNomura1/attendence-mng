class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "#{user.username}さん、ようこそSharevelへ"
      #ログイン情報記憶
      if params[:session][:remember_me] == "1"
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
      else
        user.update_attribute(:remember_digest, nil)
        cookies.delete(:user_id)
        cookies.delete(:remember_token) 
      end
      redirect_to root_path
    else
      flash.now[:danger] = "有効な組み合わせではありません"
      render :new
    end
  end

  def destroy
    # 作成したcookieを削除
    current_user.update_attribute(:remember_digest, nil)
    cookies.delete(:user_id)
    cookies.delete(:remember_token) 
    session.delete(:user_id)
    @current_user = nil
    redirect_to top_path
  end
end