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
    all.sort_by{|a| a.articles.count }.last
  end

  def self.with_most_upvoted_article
    Article.most_upvoted.author.name
  end
end
