require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  describe 'GET /comments' do
    let!(:user) { create(:user) }
    let!(:article) { create(:article, user: user)}
    let!(:comments) {create_list(:comment, 3, article: article, user: user)}
    
    it '200ステータスが返ってくる' do
      get article_comments_path(article_id: article.id)
      expect(response).to have_http_status(200)
    end
  end
end
