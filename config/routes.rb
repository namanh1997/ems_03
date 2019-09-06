Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    
    get "/do_exam", to: "trainee_exams#do_exam"
    get "/signin", to: "sessions#new"
    post "/signin", to: "sessions#create"
    delete "/signout", to: "sessions#destroy"
    resources :users, :subject, :questions, :exams, :trainee_exams
    resources :mark_exams, only: :index
  end
end
