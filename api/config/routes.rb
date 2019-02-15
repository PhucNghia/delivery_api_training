Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :orders do
        resources :products, except: :show
      end
    end
  end
  post "sign_in", to: "sessions#create"
  post "sign_up", to: "users#create"
end
