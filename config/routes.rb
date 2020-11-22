Rails.application.routes.draw do
  root 'homes#top'
  get 'favorites/create' 
  get 'favorites/destroy' 
  get 'comments/create' 
  get 'comments/destroy' 
  get "users/:id/favorites" => "users#favorites"
  get "users/:id/comments" => "users#comments"
  post '/posts/:post_id/favorites' => "favorites#create"
  delete '/posts/:post_id/favorites' => "favorites#destroy"

  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/destroy" => "posts#destroy"
  patch "posts/:id/update" => "posts#update"

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
   }
  devise_scope :user do
    post 'users/guest_sign_in', :to => 'users/sessions#new_guest'
  end
  get "/mypage" => "users#mypage"
  
  resources :posts do
    resource :favorites, :only => [:create, :destroy]
    resources :comments, :only => [:create, :destroy]
  end
  resources :users, :only => [:show, :edit, :update]
end
