class AuthorController < ApplicationController
  def index
    # require 'pry' ; binding.pry
    @authors = Author.with_articles.paginate(page: params[:page])
  end
end
