Rails.application.routes.draw do
  root 'homes#top'
  # get 'posts/index' => 'posts#index'
  # get 'posts/:id' =>　'posts#show'
  # get 'posts/:new' => 'posts#new'
  # get 'posts/:id/edit' => 'posts#edit'
  # post 'posts/create' => 'posts#create'
  # post 'posts/:id/update' => 'posts#update'
  # post 'posts/:id/destroy' => 'posts#destroy'
  devise_for :users
  # get 'homes/top'
end
