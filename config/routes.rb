Rails.application.routes.draw do
  root to: 'pages#index'
  # User Sessions
  get 'users/login', to: "sessions#new"
  post 'users/login', to: "sessions#create"
  delete 'users/logout', to: "sessions#destroy"
  #Teacher sign up 
  get 'teachers/sign_up', to: "users#teacher_sign_up"
  get 'students/sign_up', to: "users#student_sign_up"
  #Student sign up 
  resources :teachers
  resources :users

  # Search exam
  get 'exams/search', to: "exams#search_page"
  post 'exams/search', to: "exams#search"
  get 'exams/:id/preview', to: "exams#preview"
  # Attend exam
  get 'exams/:id/answersheet', to: "exams#answer_sheet"
  # Submit exam
  post 'exams/:id/answersheet', to: "results#submit"

  # questions
  post 'exams/:exam_id/questions', to: "questions#create"
  get 'exams/:exam_id/questions/new', to: "questions#new"
  get 'exams/:exam_id/questions/:id/edit', to: "questions#edit"
  put 'exams/:exam_id/questions/:id', to: "questions#update"
  delete 'exams/:exam_id/questions/:id', to: "questions#destroy"

  # exams
  resources :exams do
    resources :questions, only: [:create, :new, :edit, :update, :destroy]
  end

  # Search result page
  get 'students/results/search', to:"results#find_result_page"
  # Search Result
  post 'students/results/search', to: "results#find_result"

  # View Individual 
  get 'exams/:exam_id/results/:result_id', to: "results#get_result"

  # My results
  get 'teacher/exams/:id/results', to: "results#exam_results"

  # Publish results
  put 'exams/:id/publish', to: "results#publish"

  get '*path', to: "pages#error"
end
