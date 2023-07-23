Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "articles#index"

  #get "/articles", to: "articles#index"
  #get "/articles/:id", to: "articles#show"

  get "/articles/dummy", to: "articles#dummy"

  resources :articles do
    resources :comments
  end
end

# for my forgetful self:
=begin
    Prefix Verb     URI     Pattern                         Controller#Action
            root     GET    /                               articles#index
  articles_dummy     GET    /articles/dummy(.:format)       articles#dummy
        articles     GET    /articles(.:format)             articles#index
                    POST    /articles(.:format)             articles#create
      new_article   GET     /articles/new(.:format)         articles#new
    edit_article    GET     /articles/:id/edit(.:format)    articles#edit
          article    GET    /articles/:id(.:format)         articles#show
                    PATCH   /articles/:id(.:format)         articles#update
                    PUT     /articles/:id(.:format)         articles#update
                    DELETE  /articles/:id(.:format)         articles#destroy

Now I was having trouble figuring out why `new_article_path` in index.html.erb
was working but not my `dummy_articles_path` was failing despite being set up in
the same manner across all the relevant files...until i checked the rails documentaiton
and it mentioned `new_article` in the prefix verb section being tied to the GET articles#new
action and url pattern. which lead me to realize that my path needs to be instead structured
as `articles_dummy_path`...as based off the /articles/dummy line above.
=end