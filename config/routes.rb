Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users

  get '/:container/sitemap(:id).:format.:compression' => 'sitemap#show'
  get '/search/:query', to: 'search#index'
  get '/search', to: 'search#index'
  get '/:container/:record_id', to: 'record#index'
end
