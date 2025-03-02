class ArticlesController < ApplicationController
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]
  before_action :require_user, except: [ :index, :show ]
  before_action :require_same_user, only: [ :edit, :update, :destroy ]

  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new # make sure we have an instance on initial page load
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      flash[:notice] = "Article was created successfully."
      redirect_to @article # shorthand for the above line
    else
      # need to add status: :unprocessable_entity in Rails 8
      render :new, status: :unprocessable_entity
      # you can also use a symbol instead of a string. i.e :new instead of "new"
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article updated successfully."
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private
  def set_article
    # need exception handling for RecordNotFound
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if !(current_user.admin? || current_user == @article.user)
      flash[:alert] = "You can only edit your own articles"
      redirect_to @article
    end
  end
end
