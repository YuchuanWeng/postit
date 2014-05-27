class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create]
  before_action :require_admin, only: [:new, :create]

  def show
    @category = Category.find_by slugs: category_params
    @category = Category.all
    #@post = Post.find(params[:id])
    #for specific and each post
    #render the show template
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category is created."
      redirect_to root_path
    else
      render 'new'
      end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

end
