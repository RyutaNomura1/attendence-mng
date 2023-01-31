class HelpfulsController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    current_user.helpfuls.create(question_id: @question.id)
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    @question = Question.find(params[:question_id])
    helpful = current_user.helpfuls.find_by(question_id: @question.id)
    helpful.destroy
    redirect_back(fallback_location: root_path)
  end 
end
