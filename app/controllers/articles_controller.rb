class ArticlesController < ApplicationController
  def show
    # binding.break
    # need exception handling for RecordNotFound
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new # make sure we have an instance on initial page load
  end

  def edit
    # need exception handling for RecordNotFound
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :description))

    if @article.save
      flash[:notice] = "Article was created successfully."
      # redirect_to article_path(@article)
      redirect_to @article # shorthand for the above line
    else
      # need to add status: :unprocessable_entity in Rails 8
      render :new, status: :unprocessable_entity
      # you can also use a symbol instead of a string. i.e :new instead of "new"
    end
  end

  def update
    # need exception handling for RecordNotFound
    @article = Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = "Article updated successfully."
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end
end
