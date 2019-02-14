Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :orders
    end
  end
  post "sign_in", to: "sessions#create"
  post "sign_up", to: "users#create"
end
