require "application_system_test_case"

class ExamsTest < ApplicationSystemTestCase
  setup do
    @exam = exams(:one)
  end

  test "visiting the index" do
    visit exams_url
    assert_selector "h1", text: "Exams"
  end

  test "creating a Exam" do
    visit exams_url
    click_on "New Exam"

    fill_in "End time", with: @exam.end_time
    fill_in "Instructions", with: @exam.instructions
    fill_in "Pass mark", with: @exam.pass_mark
    fill_in "Start time", with: @exam.start_time
    fill_in "Subject", with: @exam.subject
    fill_in "Total marks", with: @exam.total_marks
    fill_in "User", with: @exam.user_id
    click_on "Create Exam"

    assert_text "Exam was successfully created"
    click_on "Back"
  end

  test "updating a Exam" do
    visit exams_url
    click_on "Edit", match: :first

    fill_in "End time", with: @exam.end_time
    fill_in "Instructions", with: @exam.instructions
    fill_in "Pass mark", with: @exam.pass_mark
    fill_in "Start time", with: @exam.start_time
    fill_in "Subject", with: @exam.subject
    fill_in "Total marks", with: @exam.total_marks
    fill_in "User", with: @exam.user_id
    click_on "Update Exam"

    assert_text "Exam was successfully updated"
    click_on "Back"
  end

  test "destroying a Exam" do
    visit exams_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Exam was successfully destroyed"
  end
end
