class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index]
  before_action :require_creator, only: [:edit, :update]

  def index
    @posts = Post.all.sort_by{ |x| x.total_votes}.reverse
    #render index.html.erb
  end

  def show
    @comment = Comment.new
    #@post = Post.find(params[:id])
    #for specific and each post
    #render the show template
  end

  def new
   @post = Post.new
  end

  def create
   @post = Post.new(post_params)
   @post.creator = current_user  #check again: identify user or creator

   if @post.save
     flash[:notice] = "Your post is created."
     redirect_to posts_path
   else  #validation error #render means we have the access to the instance variable
     render 'new'
   end
  end

  def edit
  end

  def update
  if @post.update(post_params)
     flash[:notice] = "Your post is updated."
     redirect_to posts_path
   else  #validation error
     render 'edit'
   end
  end

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = 'Your vote is counted.'
        else
          flash[:error] = 'You can only vote once.'
        end
        redirect_to :back
      end
      format.js
      # expecting a file called vote.js.erb
    end
  end

  private
  def post_params
   params.require(:post).permit(:title, :description, category_ids: [])
  end

  def set_post
    @post = Post.find_by slugs: params[:id]
  end

  def require_creator
    access_denied unless logged_in? and (current_user == @post.creator || current_user.admin?)
  end


end


