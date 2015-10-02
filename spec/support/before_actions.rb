RSpec.configure do |config|
  config.before do
    # load 'db/seeds.rb'

    Author.generate_authors(50)

    author1 = Author.create(name: "jeff", created_at: Date.new(2014,1,1))
    author1.articles << Article.create(name: "5 upvoted article",
                                      body: "this article has 5 upvotes",
                                      upvotes: 5)

    author1.articles << Article.create(name: "1 upvoted article",
                                      body: "this article has 1 upvote",
                                      upvotes: 1)

  end
end
