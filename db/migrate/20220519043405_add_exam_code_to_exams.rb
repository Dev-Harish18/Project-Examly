class AddExamCodeToExams < ActiveRecord::Migration[6.1]
  def change
    add_column :exams, :exam_code, :string
  end
end
