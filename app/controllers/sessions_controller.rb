class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "#{user.username}さん、ようこそSharevelへ"
      redirect_to root_path
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