json.extract! exam, :id, :subject, :instructions, :pass_mark, :total_marks, :start_time, :end_time, :user_id, :created_at, :updated_at
json.url exam_url(exam, format: :json)
