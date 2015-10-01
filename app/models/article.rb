class Article < ActiveRecord::Base
  belongs_to :author
  has_many :comments
  scope :with_comments, -> { includes(:comments) }

  def self.all_names
    # all.map do |art|
    #   art.name
    # end
    pluck(:name)
  end

  def self.most_upvoted
    order(upvotes: :desc).first
  end

  def self.five_longest_article_names
    order("LENGTH(name) DESC").limit(5).pluck(:name)
    # limit(5).order("(LENGTH(name)) desc").pluck(:name)
    # all.sort_by do |art|
    #   art.name
    # end.last(5).map do |art|
    #   art.name
    # end
  end

  def self.articles_with_names_less_than_20_char
    where("LENGTH(name) < 20")
    # where("length(name) < 20")
    # select do |art|
    #   art.name.length < 20
    # end
  end
end
