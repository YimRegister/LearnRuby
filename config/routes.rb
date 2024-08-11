Rails.application.routes.draw do
  # mainpage
  
  
  # GET pages
  get "about", to: "about#index"

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "log_in", to: "sessions#new"
  post "log_in", to: "sessions#create"
  

  delete "logout", to: "sessions#destroy"

  # POST
  

  # DELETE
  

  root to: "main#index"
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

 
end
