class Article < ActiveRecord::Base
  belongs_to :author, counter_cache: true, touch: true
  has_many :comments
  scope :with_comments, -> { joins(:comments) }

  def self.all_names
    pluck(:name)
  end

  def self.most_upvoted
    joins(:author).where.not(upvotes: nil).order("articles.upvotes ASC").limit(1).pluck('authors.name').first
  end

  def self.five_longest_article_names
    order("LENGTH(name) DESC").limit(5).pluck(:name)
  end

  def self.articles_with_names_less_than_20_char
    where("LENGTH(name) < 20")
  end
end
