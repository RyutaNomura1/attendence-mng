class HelpfulsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @answer = Answer.find(params[:answer_id])
    current_user.helpfuls.create(answer_id: @answer.id)
  end
  
  def destroy
    @answer = Answer.find(params[:answer_id])
    helpful = current_user.helpfuls.find_by(answer_id: @answer.id)
    helpful.destroy
  end 
end
