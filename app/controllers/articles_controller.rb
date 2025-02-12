class ArticlesController < ApplicationController
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]

  def show
   end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new # make sure we have an instance on initial page load
  end

  def edit
  end

  def create
    @article = Article.new(article_params)

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
end
