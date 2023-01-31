class QuestionsController < ApplicationController

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = "#{@question.question_title}を投稿しました"
      redirect_to root_path
    else 
      render "new"
    end
  end

  def edit
    @question = Question.find(params[:id])    
  end
  
  def update
    question = Question.find(params[:id])
    if question.update(question_params)
      flash[:success] = "#{question.question_title}を更新しました"
      redirect_to root_path     
    else
      render "edit"
    end
  end
  
  def destroy
    question = Post.find(params[:id])
    question.destroy
    flash[:danger] = "質問を削除しました"
    redirect_to root_path
  end
  
  private
  
  def question_params
    params.require(:question).permit(:question_title, :question_body)
  end

end
