Rails.application.routes.draw do
  post '/signup', to: 'users#signup'
  get '/verify/:token', to: 'email_verifications#verify', as: :email_verification
  post '/login' , to: 'users#login'
  get '/resend' , to: 'email_verifications#resend_verification'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
