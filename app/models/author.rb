class Author < ActiveRecord::Base
  has_many :articles
  scope :with_articles, -> { includes(:articles) }

  def self.generate_authors(count=1000)
    count.times do
      Fabricate(:author)
    end
    first.articles << Article.create(name: "some commenter", body: "some body")
  end

  def self.most_prolific_writer
    order(articles_count: :desc).first
  end

  def self.with_most_upvoted_article
    Article.most_upvoted.author.name
  end
end
