class AnswersController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_answer_user,   only: :destroy
  before_action :define_question
  
  def create
    @answer = current_user.answers.build(answer_params)
    @answer.question_id = @question.id
    @answer.save
    respond_to do |format|
      format.html { redirect_back fallback_location: question_path(@question) }
      format.js
    end  
  end
  
  def destroy
    Answer.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: question_path(@question) }
      format.js
    end  
  end
  
  
  private
  
  def answer_params
    params.require(:answer).permit(:answer_body)
  end
  
  def define_question
    @question = Question.find(params[:question_id])
  end
  
end
