class CategoriesController < ApplicationController
  before_action :require_admin, except: [ :index, :show ]
  before_action :set_category, only: [ :show, :edit, :update ]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category successfully created"
      redirect_to @category
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end


  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit
  end
  def update
    if @category.update(category_params)
      flash[:notice]= "category name updated successfully"
      redirect_to @category
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "Only admins can perform this action"
      redirect_to categories_path
    end
  end
end
