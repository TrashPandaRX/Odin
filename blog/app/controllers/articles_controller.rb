class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    # never really used turbos (see the show.html.erb), gotta read up on it
  end

  def new
    @article = Article.new
  end

  def create
    #@article = Article.new(title: "...", body: "...")
    @article = Article.new(article_params)

    #if the article can succesfully save, do so and redirect
    if @article.save
      redirect_to @article
    #otherwise render a new article (basically clear the fields), and throw an HTTP unprocessable entity error
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other # this is likely a 3xx series status since its a redirect, yep 303
  end

  def dummy
    @article = Article.new
  end

  private
    def article_params
      params.require(:article).permit(:title, :body)
    end
end
