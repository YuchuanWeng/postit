PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :posts, except: [:destroy] do
    resources :comments, only: [:create]
  end
  #nested routes allow we to capture the relationship. In this case, It is supposed that
  # In each post, I have multiple comments.
  #In addition, the path will be nested in a way such as posts/:post_id/comments which is exactly I want for.
  #Shallow Nesting: One way to avoid deep nesting under and to build minimal amount of information.

  resources :categories, only: [:create, :new, :show]
  resources :users

  #The 4th line represent 6 line og get/patch/put, etc
  #get  /             post#index  => display a list of all posts
  #post posts/:create posts#create =>create a new post
  #get posts/:new     posts#new => returning an HTML form for creating a new post
  #get posts/:edit    posts#edit =>returning an HTML form for editing a new post
  #get posts/:show    posts#show => display a specific post
  #patch posts/:update posts#update => udpate a specific post
  #put posts/:update   posts#update =>update a specific post

end
