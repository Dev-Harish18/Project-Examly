require "test_helper"

class ExamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exam = exams(:one)
  end

  test "should get index" do
    get exams_url
    assert_response :success
  end

  test "should get new" do
    get new_exam_url
    assert_response :success
  end

  test "should create exam" do
    assert_difference('Exam.count') do
      post exams_url, params: { exam: { end_time: @exam.end_time, instructions: @exam.instructions, pass_mark: @exam.pass_mark, start_time: @exam.start_time, subject: @exam.subject, total_marks: @exam.total_marks, user_id: @exam.user_id } }
    end

    assert_redirected_to exam_url(Exam.last)
  end

  test "should show exam" do
    get exam_url(@exam)
    assert_response :success
  end

  test "should get edit" do
    get edit_exam_url(@exam)
    assert_response :success
  end

  test "should update exam" do
    patch exam_url(@exam), params: { exam: { end_time: @exam.end_time, instructions: @exam.instructions, pass_mark: @exam.pass_mark, start_time: @exam.start_time, subject: @exam.subject, total_marks: @exam.total_marks, user_id: @exam.user_id } }
    assert_redirected_to exam_url(@exam)
  end

  test "should destroy exam" do
    assert_difference('Exam.count', -1) do
      delete exam_url(@exam)
    end

    assert_redirected_to exams_url
  end
end
