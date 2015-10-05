class ArticlesController < ApplicationController
  def show
      @article = Article.with_comments.find_by_id(params[:id])
  end
end
