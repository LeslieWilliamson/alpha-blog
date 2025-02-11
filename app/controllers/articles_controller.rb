class ArticlesController < ApplicationController
  def show
    # binding.break
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new # make sure we have an instance on initial page load
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
end
