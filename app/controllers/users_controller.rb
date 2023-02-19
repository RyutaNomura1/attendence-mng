class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :edit, :create]
  before_action :correct_user, only: [:edit, :update, :edit_password, :update_password
  ]
  
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
  
  def show
    @user = User.find(params[:id])
    # コメント投稿用
    @comment = Comment.new
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(update_user_params)
      flash[:success]="#{@user.username}さんのプロフィールを更新しました"
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end
  
  def edit_password
    @user = User.find(params[:id])
  end
  
  def update_password
    @user = User.find(params[:id])
    if @user.update(update_password_params)
      flash[:success]="#{@user.username}さんのパスワードを変更しました"
      redirect_to user_path(@user)
    else
      render "edit_password"
    end
  end

  private 
    def create_user_params
      params.require(:user).permit(:username,:email, :password,
                                   :password_confirmation)
    end
    
    def update_user_params
      params.require(:user).permit(:username, :email, :profile_image, :profile,
                                   :travel_period, :current_location)
    end
    
    def update_password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
    
end
