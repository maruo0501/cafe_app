Rails.application.routes.draw do
  root 'homes#top'
  get '/posts/index', to:　'posts#index'
  get '/posts/:id', to:　'posts#show'
  get '/posts/:new', to:　'posts#new'
  get '/posts/:id/edit', to:　'posts#edit'
  post '/posts/create', to: 'posts#create'
  post '/posts/:id/update', to: 'posts#update'
  post '/posts/:id/destroy', to: 'posts#destroy'
  devise_for :users
  # get 'homes/top'
end
