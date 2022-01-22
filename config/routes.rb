Rails.application.routes.draw do

  get "relationships/followings"
  get "relationships/followers"
  devise_for :users
  root to: "homes#top"
  get "/homes/about" => "homes#about"
  get "/homes/my_calender" => "homes#my_calender"
  get "/bookmarks" => "bookmarks#index"
  post "/homes/guest_sign_in", to: "homes#new_guest"

  resources :declutters do
    resources :declutter_comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
    resource :bookmarks, only: [:create, :destroy]
  end

  resources :users, only:[:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

end
