class StatsController < ApplicationController
  def index
    @five_longest_article_names = Article.five_longest_article_names
    @prolific_author = Author.most_prolific_writer
    @author_with_most_upvoted_article = Author.with_most_upvoted_article
    @articles_name_array_with_index = (1..Author.sum(:articles_count)).to_a.paginate(page: params[:page])
    @article_names = Article.order(:id).paginate(page: params[:page]).all_names
    @short_articles = Article.articles_with_names_less_than_20_char
  end
end
