class AuthorController < ApplicationController
  cache_sweeper :author_sweeper, only: [ :create, :update, :destroy ]

  def index
    @authors = Author.with_articles.paginate(page: params[:page])
  end
end
