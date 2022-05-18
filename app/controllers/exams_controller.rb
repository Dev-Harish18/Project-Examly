class ExamsController < ApplicationController
  before_action :set_exam, only: [ :show, :edit, :update, :destroy ]

  # GET /exams or /exams.json
  def index
    @exams = Exam.all
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
    @exam = Exam.new(exam_params)
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
        render :edit, status: :unprocessable_entity 
      end
  end

  # DELETE /exams/1 or /exams/1.json
  def destroy
    @exam.destroy
    redirect_to exams_url, notice: "Exam was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam
      @exam = Exam.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def exam_params
      params.require(:exam).permit(:subject, :instructions, :pass_mark, :total_marks, :start_time, :end_time, :user_id)
    end
end
