class AnswersController < ApplicationController
  before_action :define_answer
  
  def create
    answer = current_user.answers.build(answer_params)
    if answer.save
      redirect_to question_path(question)
    else
      render "questions/show"
    end
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to question_path(question)
  end
  
  
  private
  
  def answer_params
    params.require(:answer).permit(:quesiton_id, :answer_body)
  end
  
  def define_answer
    question = Question.find(params[:question_id])
  end
  
end
