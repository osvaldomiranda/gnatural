CapistranoDeploy::Application.routes.draw do
  resources :owner_centers

  devise_for :users
  root to: "home#index"
  get "home/index"
end
