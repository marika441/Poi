Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  get "/home/about" => "homes#about"
  get "/bookmarks" => "bookmarks#index"
  resources :declutters do
    resources :declutter_comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
    resource :bookmarks, only: [:create, :destroy]
  end
  resources :users, only:[:index, :show, :edit, :update]

end
