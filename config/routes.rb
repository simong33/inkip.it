Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#landing'

  resources :users, only: [:show] do
    resources :books, only: [:index], name_prefix: "user_"
  end

  resources :books, only: [:show, :new, :create, :update, :destroy] do
    resources :chapters, only: [:create, :show, :update], name_prefix: "book_"
    resources :characters, only: [:create, :index, :show], name_prefix: "book_"
    resources :places, only: [:create, :index, :show], name_prefix: "book_"
  end

    # resources :books, only: [:index, :show, :new, :create] do
    #   resources :chapters, only: [:create, :show, :update] do
    #     resources :appearances, only: [:create, :update]
    #   end
    #   resources :characters, only: [:create, :index, :show]
    #   resources :places, only: [:create, :index, :show]
    # end

  get "books/:book_id/statistics" => "books#statistics", as: :book_statistics

  get "books/:book_id/settings" => "books#settings", as: :book_settings

  get "books/:book_id/chapters/:chapter_id/refresh_wordcount" => "chapters#refresh_wordcount", as: :refresh_wordcount

  get "books/:book_id/download" => "books#download", as: :download_book, format: 'docx'

end
