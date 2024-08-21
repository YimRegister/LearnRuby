Rails.application.routes.draw do
  # mainpage
  
  

  get "about", to: "about#index"
  get "tips", to: "tips#index"
  
  get "ai", to: "ai#index"

  get "aiplus", to: "aiplus#index"
  get "aiplus", to: "aiplus#generate_imageplus"
  post "aiplus", to: "aiplus#index"
  

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  
  #get "save_image", to: "save_images#new"
  get "save_image", to: "aiplus#index"
  post "save_image", to: "aiplus#save_image"

  get "edit_image_titles", to: "edit_image_titles#edit"
  

  get "log_in", to: "sessions#new"
  post "log_in", to: "sessions#create"

  get "dashboard", to: "dashboard#index"
  delete "deleteimage", to: "dashboard#destroy"

  get "password", to: "passwords#edit"
  patch "password", to: "passwords#update"

  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
  get "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"

  delete "logout", to: "sessions#destroy"

  

  root to: "main#index"
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check

 
end
