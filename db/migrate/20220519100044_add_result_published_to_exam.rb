class AddResultPublishedToExam < ActiveRecord::Migration[6.1]
  def change
    add_column :exams, :is_results_published, :boolean, default: false
  end
end
