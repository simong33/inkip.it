Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  authenticated :user do
    root 'books#index', as: :authenticated_root, "user_id"=>true
  end

  root to: 'pages#landing'

  resources :users, only: [:show, :update] do
    resources :books, only: [:index], name_prefix: "user_"
  end

  resources :books, only: [:show, :new, :create, :update, :destroy] do
    resources :chapters, only: [:create, :show, :update, :destroy], name_prefix: "book_"
    resources :characters, only: [:create, :index, :show, :update, :destroy], name_prefix: "book_"
    resources :places, only: [:create, :index, :show, :destroy], name_prefix: "book_"
  end

  resources :users, only: :show

  resources :books, only: :index

  resources :relationships, only: [:create, :destroy]

  resources :reactions, only: [:create, :update]

  get "modal_chapters" => 'books#modal_chapters', as: 'modal_chapters'

  get "books" => "books#index",  as: :user_root_path

  get "books/:book_id/statistics" => "books#statistics", as: :book_statistics

  get "books/:book_id/settings" => "books#settings", as: :book_settings

  get "books/:book_id/chapters/:chapter_id/refresh_wordcount" => "chapters#refresh_wordcount", as: :refresh_wordcount

  get "books/:book_id/download" => "books#download", as: :download_book, format: 'docx'

  get "/rankings" => "pages#rankings", as: :rankings

  get "/privacy" => "pages#privacy_policy"

  get "/tos" => "pages#tos"

  get "/cgu" => "pages#cgu", as: :cgu

  get "/mentions_legales" => "pages#mentions_legales", as: :mentions_legales

  mount Attachinary::Engine => "/attachinary"

end
