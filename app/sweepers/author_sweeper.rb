class AuthorSweeper < ActionController::Caching::Sweeper
  observe Author

  def expire_cached_content(author)
    Rails.cache.delete(author.cache_key)
  end

  alias_method :after_commit, :expire_cached_content
  alias_method :after_destroy, :expire_cached_content
end
