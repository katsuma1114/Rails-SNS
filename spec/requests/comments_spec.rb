require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user)}
  let!(:comments) {create_list(:comment, 3, article: article, user: user)}
  
  describe 'GET /comments' do
    
    it '200ステータスが返ってくる' do
      get article_comments_path(article_id: article.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /comments' do

    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it "投稿が保存される" do
        comment_params = attributes_for(:comment)
        post article_comments_path( {article_id: article.id, comment: comment_params} )
        expect(response).to have_http_status(302)
        expect(Comment.last.content).to eq(comment_params[:content])
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        comment_params = attributes_for(:comment)
        post article_comments_path( {article_id: article.id, comment: comment_params} )
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
