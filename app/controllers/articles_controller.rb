class ArticlesController < ApplicationController
  before_action :set_article, only: :show
  
  def show
  end

  private

    def set_article
      @article = Article.with_comments.find_by_id(params[:id])
    end
end
