Rails.application.routes.draw do
  devise_for :users
  root to: 'books#index'
  resources :books, only: [:index, :show, :new, :create] do
    resources :chapters, only: [:create, :show, :update]
    resources :characters, only: [:create]
    resources :places, only: [:create]
  end
end
