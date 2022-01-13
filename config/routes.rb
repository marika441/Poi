Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  get "/home/about" => "homes#about"
  resources :declutters do
    resources :declutter_comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
  end

end
