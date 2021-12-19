class CommentsController < ApplicationController
    before_action :authenticate_user!
    def index
        @comments = Comment.all

        @article = Article.find(params[:article_id])
        @comment = @article.comments.build #indexページでnewする
    end

    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.build(comment_params)
        @comment.user = current_user
        if @comment.save
            redirect_to action: :index, notice: 'コメントを追加しました'
        else
            flash.now[:error] = '追加できませんでした'
            render :index
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:content)
    end
end