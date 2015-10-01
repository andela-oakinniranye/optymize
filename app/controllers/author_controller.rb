class AuthorController < ApplicationController
  def index
    @authors = Author.with_articles.all
  end
end
