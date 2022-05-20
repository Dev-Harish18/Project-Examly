class ExamsController < ApplicationController
  before_action :require_user
  before_action :set_exam, only: [ :show, :edit, :update, :destroy, :preview]

  # GET /exams or /exams.json
  def index
    @exams = current_user.exams
  end

  # GET /exams/1 or /exams/1.json
  def show
  end

  # GET /exams/new
  def new
    @exam = Exam.new
  end

  # GET /exams/1/edit
  def edit
  end

  # POST /exams or /exams.json
  def create
    @exam = current_user.exams.build(exam_params)
    if @exam.save
      redirect_to exam_url(@exam), notice: "Exam was successfully created." 
    else
      render :new, status: :unprocessable_entity 
    end
  end

  # PATCH/PUT /exams/1 or /exams/1.json
  def update
      if @exam.update(exam_params)
        redirect_to exam_url(@exam), notice: "Exam was successfully updated." 
      else
        flash[:notice] = "Exam has been updated successfully"
        render :edit, status: :unprocessable_entity 
      end
  end

  # DELETE /exams/1 or /exams/1.json
  def destroy
    @exam.destroy
    redirect_to exams_url, notice: "Exam was successfully destroyed."
  end


  def search_page
  end

  def search
    @exam = Exam.find_by(exam_code: params[:exam_code])
    
    if @exam.blank?
      flash.now[:alert] = "No exams found for the given exam code"
      render 'search_page'
    else
      redirect_to "/exams/#{@exam.id}/preview"
    end
  end

  def preview

  end

  def answer_sheet
    @result = Result.find_by(user_id: current_user.id, exam_id: params[:id])
    unless @result.blank?
      flash[:alert] = "You already attended the exam"
      redirect_to root_path
    else
      @exam = Exam.find(params[:id])
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam
      @exam = Exam.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def exam_params
      params.require(:exam).permit(:subject, :instructions, :pass_mark, :total_marks, :start_time, :end_time)
    end

    def update_params
      params.require(:exam).permit(:subject, :instructions, :pass_mark, :total_marks, :start_time, :end_time)      
    end
end
