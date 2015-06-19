Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users

  # resources :search
  # get '/:container/:record_id', to: 'records#index'
  get '/search/:query', to: 'search#index'
  get '/search', to: 'search#index'
end
