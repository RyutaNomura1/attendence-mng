class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "#{user.username}、ようこそSharevelへ"
      redirect_to user_path
    else
      flash.now[:danger] = "有効な組み合わせではありません"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to top_path
  end
end