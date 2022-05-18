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
  resources :exams
end
