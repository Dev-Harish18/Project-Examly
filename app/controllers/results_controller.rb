class ResultsController < ApplicationController
  require 'rest-client'
  require 'json'
  require 'uri'

  def find_result_page #Search page
    
  end

  def find_result #Post call
    # debugger
    @exam = Exam.find_by(exam_code: params[:exam_code])
    
    unless @exam.blank?
      @result = Result.find_by(exam: @exam, user: current_user)
      if @result.blank?
        flash[:alert] = "Results have not yet been published"
        redirect_back(fallback_location: root_path)
      else
        redirect_to "/exams/#{@exam.id}/results/#{@result.id}"
      end
    else
      flash.now[:alert] = "No exams found for the given exam code"
      redirect_back(fallback_location: root_path)
    end
    # debugger
  end

  def exam_results # results of an exam (teacher) 
    @exam = Exam.find(params[:id])
  end

  def get_result #View individual result (teacher)
    @exam = Exam.find(params[:exam_id])    
    if current_user.role == "student" && @exam.is_results_published == false
      flash[:alert] = "Results have not yet been published"
      return redirect_back(fallback_location: root_path)
    end
    @result = Result.find(params[:result_id]) 
    @answers = Answer.where(user: @result.user, question_id: @exam.questions.pluck(:id))
  end

  def publish
    @exam = Exam.find(params[:id])

    if @exam.update(is_results_published: true)
      flash[:notice] = "Results have been published successfully"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Results have been published successfully"
      redirect_back(fallback_location: root_path)
    end
  end

  def submit 
    @result = Result.find_by(user_id: current_user.id, exam_id: params[:id])
    unless @result.blank?
      flash[:alert] = "You already attended the exam"
      return redirect_to root_path
    end

    begin
        success = ActiveRecord::Base.transaction do    
            @exam = Exam.find(params[:id])
            @exam_marks=0
            # Marks Generation
            @exam.questions.each_with_index do |question, idx|
              marks = 0
              marks = generate_marks(question, question.model_answer, params[:answers][idx]).to_f unless params[:answers][idx].blank?
              @exam_marks += marks.to_i
              current_user.answers.create!(answer: params[:answers][idx], marks: marks, question_id: question.id)
            end
            # Result Generation
            percentage = ( @exam_marks.to_f / @exam.total_marks * 100).round 
            exam_status = @exam_marks >= @exam.pass_mark ? "pass" : "fail";
        
            @exam.results.create!(marks: @exam_marks, percentage: percentage, status: exam_status, user_id: current_user.id)
            true
        end

        if success  
            flash[:notice] = "Exam has been submitted successfully"
            redirect_to root_path
        else         
            raise ActiveRecord::Rollback 
        end
    rescue => error
        puts error
        flash[:alert] = "Something went wrong! Unable to sumbit the exam"
        redirect_back(fallback_location: root_path)
    end
  end

  private

  def generate_marks(question,model_answer,answer)
    marks = 0
    # similarity score
    token = "1dd8dda405d44f7098d2aaa14867883d"
    url = "https://api.dandelion.eu/datatxt/sim/v1?text1=#{CGI.escape(model_answer)}&text2=#{CGI.escape(answer)}&token=#{token}"
    response = RestClient.get(url)
    data = JSON.parse(response, object_class: OpenStruct)
    # marks += data[:similarity] * 60
    marks = 50
    # keyword check
    count = 0 
    keywords = question.keywords.split(",")
    words = answer.split

    keywords.each do |keyword|
      words.each do |word|
        count += 1 if (keyword.downcase.strip == word.downcase.strip)
      end
    end

    if count >= keywords.count
      marks += 30
    else
      marks += (count.to_f / keywords.count * 30).to_i
    end
    # answer length
    words = answer.split(" ");
    if (words.count >= question.min_length) 
      marks += 10
    else 
      marks += ((words.count.to_f / question.min_length).to_f * 10).to_i
    end
    # final score
    final_marks = (marks.to_f / 100 * question.marks).to_i
  end

end

