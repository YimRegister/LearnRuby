Rails.application.routes.draw do
  # mainpage
  
  
  # GET pages
  get "about", to: "about#index"
  get "sign_up", to: "registrations#new"
   get "log_in", to: "registrations#login"

  # POST
  post "sign_up", to: "registrations#create"

  root to: "main#index"
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

 
end
