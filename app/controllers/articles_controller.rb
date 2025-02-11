class ArticlesController < ApplicationController
  def show
    # binding.break
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end
end
