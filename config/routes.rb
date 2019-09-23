Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    devise_for :users, controllers: {sessions: "users/sessions",
      registrations: "users/registrations"}

    get "/do_exam", to: "trainee_exams#do_exam"
    resources :subject, :questions, :exams, :trainee_exams
    resources :users, only: %i(show index)
    resources :mark_exams, only: :index
  end
end
