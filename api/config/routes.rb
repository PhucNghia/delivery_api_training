Rails.application.routes.draw do
  post "sign_in", to: "sessions#create"
  post "sign_up", to: "users#create"
end
