Rails.application.routes.draw do
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "posts#index"
  get "/about", to: "posts#about"
  resources :articles
  get 'signup', to: 'users#new'
  #form looks for users path to submit form when completed, so we need this:
  #post 'users', to: 'users#create'
  #or I can get all the routes set up automatically (except the signup one I already have): 
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :categories, except: [:destroy]
end
