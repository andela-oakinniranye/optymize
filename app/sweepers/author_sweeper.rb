class AuthorSweeper < ActionController::Caching::Sweeper
  observe Author

  def expire_cached_content(author)
    expire_fragment(author)
  end

  alias_method :after_commit, :expire_cached_content
  alias_method :after_destroy, :expire_cached_content
end
