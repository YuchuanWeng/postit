class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]


  def index
    @posts = Post.all
    #render index.html.erb
  end

  def show
    #for specific and each post
    #render the show template
  end

  def new
   @post = Post.new
  end

  def create
   @post = Post.new(post_params)
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

  private
  def post_params
   params.require(:post).permit!
  end

  def set_post
    @post = Post.find(params[:id])
  end
end


