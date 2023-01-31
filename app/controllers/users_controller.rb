class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :edit, :create]
  before_action :correct_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user= User.new(create_user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "#{@user.username}さんは新規登録されました"
      redirect_to root_url
    else
      render "new"
    end
  end
  
  def index
    @users = User.all
  end


  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(update_user_params)
    redirect_to user_path(@user)
  end
  
  
  private 
    def create_user_params
      params.require(:user).permit(:username,:email, :password,
                                   :password_confirmation)
    end
    
    def update_user_params
      params.require(:user).permit(:username,:profile_image, :profile, :email,)
    end
    
end
