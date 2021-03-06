CapistranoDeploy::Application.routes.draw do


  resources :kinesiologists

  get "planyo/index"
  get "admin/index"
  get "admin/vta_origen_toxls"
  get "admin/user_index"
  get "admin/reset_pass"
  get "admin/kine_yield"


  get "telephony/index"

  root to: "home#index"
  get "home/index"

  match 'api/v1/sessions/login', to: 'api/v1/sessions#options', as: :sessions_login_options, via: :options
  match 'api/v1/sessions/logout', to: 'api/v1/sessions#options', as: :sessions_logout_options, via: :options

  resources :events

  resources :comments
  resources :plans
  resources :owners
  devise_for :users

  resources :centers do
    collection do
      get :owners
      post :newowner
    end   
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :sessions do
        collection do
          post :login
          post :logout
        end
      end     
    end
  end

end
