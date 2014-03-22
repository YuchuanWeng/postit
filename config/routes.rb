PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: [:destroy] do
    resources :comments, only: [:create]
  end

  resources :categories, only: [:create, :new, :show]

  #The 4th line represent 6 line og get/patch/put, etc
  #get  /             post#index
  #post posts/:create posts#create
  #get posts/:new     posts#new
  #get posts/:edit    posts#edit
  #get posts/:show    posts#show
  #patch posts/:update posts#update
  #put posts/:update   posts#update

end
