class CommentsController < ApplicationController
    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.create(comment_params)
        redirect_to article_path(@article)
    end
    
    private
        def comment_params
            # getting this data from the comment form located in show.html.erb
            # suggested that :status be added for section 9.1 of: https://guides.rubyonrails.org/getting_started.html
            # https://stackoverflow.com/questions/69352954/comments-section-from-ruby-on-rails-blog-tutorial-is-not-rendering
            # dont think its applicable since this dev went further along the tutorial.
            params.require(:comment).permit(:commenter, :body)
        end
end
