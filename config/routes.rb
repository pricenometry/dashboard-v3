Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users

  get '/search/:query', to: 'search#index'
  get '/:container/:record_id', to: 'records#index'
end
