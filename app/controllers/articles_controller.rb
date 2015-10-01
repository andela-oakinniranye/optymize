class ArticlesController < ApplicationController
  def show
    @article = Article.with_comments.find(params[:id])
  end
end
