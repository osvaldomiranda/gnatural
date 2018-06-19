CapistranoDeploy::Application.routes.draw do
  resources :owner_centers

  devise_for :users
  root to: "home#index"
  get "home/index"

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_error", :via => :all
end
