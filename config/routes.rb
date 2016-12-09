Rails.application.routes.draw do
  root to: "games#index"
  resources :users, :except => [:index]
  resources :games, :except => [:edit, :update, :destroy] do
    resources :ships
  end
  resources :sessions, only: [:new, :create]
  resources :shots, only: [:create, :index]

  delete "/logout" => "sessions#destroy"

end
