PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
    get '/register', to:'users#new'
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    get '/logout', to: 'sessions#destroy'

  resources :posts, except: [:destroy] do
    member do
      post :vote
    end

    resources :comments, only: [:create] do
      member do
        post :vote
      end
    end

  end

  #nested routes allow we to capture the relationship. In this case, It is supposed that
  # In each post, I have multiple comments.
  #In addition, the path will be nested in a way such as posts/:post_id/comments which is exactly I want for.
  #Shallow Nesting: One way to avoid deep nesting under and to build minimal amount of information.

  resources :categories, only: [:create, :new, :show]
  resources :users, only: [:show, :create, :edit, :update]

end
