Rails.application.routes.draw do
  root 'homes#top'
  # resources :posts
  # resources :posts, only: [:index, :new, :show, :create, :edit, :update]
  # post "posts/:id/update" => "posts#update"
  # get 'homes/top'
  # get "users/:id" => "users#show"
  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/destroy" => "posts#destroy"
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
   }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  patch "posts/:id/update" => "posts#update"
  resources :users, only: [:show, :edit, :update]
  get "/mypage" => "users#mypage"
end
