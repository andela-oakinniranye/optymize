# Andela Rails Checkpoint #3

## Actions Taken
  Application is available [here: Optymize](https://optymize.herokuapp.com "Optymize")
  Optimizing an application may be things we take for granted, not because it's not important but because at times our focus is on getting things done.
  
  However, a time comes when an application becomes unscalable due to optimizations and other house-cleaning that has not been done.
  
  Knowing to optimize is one part, knowing what to optimize is another part and the final part is knowing to optimize efficiently.
  
  This project included many unnecessary calls which greatly bogged down the application.
  
  In order to optimize this application, my first touch-point was on the active record queries, which obviously weren't efficient.
  Afterwards, I implemented some methods that worked around other bugs, cached pages and included the observer/sweeper module of ActiveRecord which would clean up a cache after any updates.
  
## Challenges Faced
  The biggest challenge I faced with this project was with the 'rails-observer' gem, which wasn't loading properly in production
  To fix this, I added an extra ``require "rails/observers/activerecord/active_record"`` in my config/application.rb file
  Another challenge which surfaced last was with postgres db, which was incorrectly ordering null to the top, when I called order.
  Approach I could have taken, which though unscalable was to add a Article.order('upvotes DESC NULLS LAST'), but this would break with SQLite and maybe other DBs, however a ``where.not(upvotes: nil)`` seem to work fine.
  
To work on the project on your own, you may clone from the [source: Rails_Worst_App](https://github.com:andela/checkpoint_rails_worst_app "Rails Worst App") or [mine: Optymize](https://github.com:andela-oakinniranye/optymize "Optymize")

1. Git clone this app and follow the instructions below.

```bash
git clone git@github.com:andela-oakinniranye/optymize
```

### This is one of the worst performing Rails apps ever.

Currently, the home page takes this long to load:

```bash
...
Article Load (0.5ms)  SELECT "articles".* FROM "articles" WHERE "articles"."author_id" = ?  [["author_id", 3000]]
Article Load (0.5ms)  SELECT "articles".* FROM "articles" WHERE "articles"."author_id" = ?  [["author_id", 3001]]
Rendered author/index.html.erb within layouts/application (9615.5ms)
Completed 200 OK in 9793ms (Views: 7236.5ms | ActiveRecord: 2550.1ms)
```

The view takes 7.2 seconds to load. The AR querying takes 2.5 second to load. The page takes close to 10 seconds to load. That's not great at all. That's just awful.

The stats page is even worse:

```bash
Rendered stats/index.html.erb within layouts/application (9.9ms)
Completed 200 OK in 16197ms (Views: 38.0ms | ActiveRecord: 4389.4ms)
```

It took 16 seconds to load and a lot of the time taken isn't even in the ActiveRecord querying or the view. It's the creation of ruby objects that is taking a lot of time. This will be explained in further detail below.

So, **What can we do?**

Well, let's focus on improving the view and the AR querying first!

Complete this tutorial first:
[Jumpstart Lab Tutorial on Querying](http://tutorials.jumpstartlab.com/topics/performance/queries.html)

# Requirements for this checkpoint
* add an index to the correct columns
* implement eager loading vs lazy loading on the right pages.
* replace Ruby lookups with ActiveRecord methods.
* fix html_safe issue.
* page cache or fragment cache the root page.
* No need for testing, but you need to get the time down to a reasonable time for both pages.
* The root page needs to implement includes, pagination, and fragment caching.

##### Index some columns. But what should we index?

[great explanation of how to index columns and when](http://tutorials.jumpstartlab.com/topics/performance/queries.html#indices)

Our non-performant app has many opportunities to index. Just look at our associations. There are many foreign keys in our database...

```ruby
class Article < ActiveRecord::Base
  belongs_to :author
  has_many :comments
end
```

##### Ruby vs ActiveRecord

Let's try to get some ids from our Article model.

Look at Ruby:

```ruby
puts Benchmark.measure {Article.select(:id).collect{|a| a.id}}
  Article Load (2.6ms)  SELECT "articles"."id" FROM "articles"
  0.020000   0.000000   0.020000 (  0.021821)
```

The real time is 0.021821 for the Ruby query.

vs ActiveRecord

```ruby
puts Benchmark.measure {Article.pluck(:id)}
   (3.2ms)  SELECT "articles"."id" FROM "articles"
  0.000000   0.000000   0.000000 (  0.006992)
```
The real time is 0.006992 for the AR query. Ruby is about 300% slower.

For example, this code is terribly written in the Author model:

```ruby
def self.most_prolific_writer
  all.sort_by{|a| a.articles.count }.last
end

def self.with_most_upvoted_article
  all.sort_by do |auth|
    auth.articles.sort_by do |art|
      art.upvotes
    end.last
  end.last
end
```

Both methods use Ruby methods (sort_by) instead of ActiveRecord. Let's fix that.

##### html_safe makes it unsafe or safe?.

This is why variable and method naming is important.

In the show.html.erb for articles, we have this code

```ruby
  <% @articles.comments.each do |com| % >
    <%= com.body.html_safe %>
  <% end %>
```

What's wrong with it?

The danger is if comment body are user-generated input...which they are.

See [here](http://stackoverflow.com/questions/4251284/raw-vs-html-safe-vs-h-to-unescape-html)

Understand now? Fix the problem.


##### Caching

Our main view currently takes 4 seconds to load

```bash
Rendered author/index.html.erb within layouts/application (5251.7ms)
Completed 200 OK in 5269ms (Views: 4313.1ms | ActiveRecord: 955.6ms)
```

Let's fix that. Read this:
[fragment caching](http://guides.rubyonrails.org/caching_with_rails.html#fragment-caching)
