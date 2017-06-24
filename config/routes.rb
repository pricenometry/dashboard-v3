Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users

  get '/trending/:type', to: 'trends#index'
  get '/trending/:container/:type', to: 'trends#index'
  get '/search/:query', to: 'search#index'
  get '/search', to: 'search#index'
  get '/:container/sitemap(:id).:format.:compression' => 'sitemap#show'
  get '/:container/:record_id', to: 'record#index'
end
