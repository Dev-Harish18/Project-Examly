class QuestionsController < ApplicationController
  before_action :require_user, :set_exam
  before_action :set_question, only: [:edit, :update, :destroy]
  
  def new
    @question = @exam.questions.build()
  end

  def create
    @question = @exam.questions.build(question_params)
    if @question.save
      redirect_to "/exams/#{@exam.id}", notice: "Question was successfully added" 
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def edit
  end
  
  def update
    if @question.update(question_params)
      redirect_to exam_path(@exam), notice: "Question was successfully updated." 
    else
      render :edit, status: :unprocessable_entity 
    end
  end
  
  def destroy
    @question.destroy
    redirect_to exam_path(@exam), notice: "Question was successfully destroyed."
  end
  
  private
  
  def question_params
    params.require(:question).permit(:question, :marks, :model_answer, :keywords, :max_length, :min_length)
  end

  def set_exam
    @exam = Exam.find(params[:exam_id])
  end

  def set_question
    @question = @exam.questions.find(params[:id])  
  end
end
