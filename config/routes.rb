Rails.application.routes.draw do
  get 'stats/index'

  get 'comments/new'
  post 'comments/create', as: "comments"

  get 'articles/:id' => "articles#show", as: :articles_show
  root to: 'author#index'
end
