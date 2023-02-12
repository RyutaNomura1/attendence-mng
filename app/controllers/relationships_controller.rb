class RelationshipsController < ApplicationController
  before_action :define_follow_user
  
  def create
    current_user.relationships.create(followed_id: params[:user_id])
    count_follows_number(@user)
  end
  
  def destroy
    current_user.relationships.find_by(followed_id: params[:user_id]).destroy
    count_follows_number(@user)
  end

  def define_follow_user
    @user = User.find(params[:user_id])
  end
  
  def count_follows_number(user)
    @followers_number = user.followers.count
    @followings_number = user.followings.count
  end
end  
