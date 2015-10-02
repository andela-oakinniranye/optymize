class AuthorController < ApplicationController
  def index
    @authors = Author.with_articles.paginate(page: params[:page])
  end
end
