class ArticlesController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @article = Article.all.order(created_at: :desc)
    end

    def new
        @article = current_user.articles.build
    end

    def create
        @article = current_user.articles.build(article_params)
        if @article.save
            redirect_to action: :index, notice: '保存できたよ！'
        else
            flash.now[:errors] = '保存に失敗しました'
            render :root_path
        end
    end

    private
    def article_params
        params.require(:article).permit(:content, images: [])
    end
end