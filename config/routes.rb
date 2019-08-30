Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    
    get "/signin", to: "sessions#new"
    post "/signin", to: "sessions#create"
    delete "/signout", to: "sessions#destroy"
    resources :users, :subject, :questions, :exams
    resources :trainee_exams, only: %i(index create new)
    resources :mark_exams, only: :index
  end
end
