require 'rails_helper'

RSpec.describe 'Article', type: :system do
    let!(:user) { create(:user) }
    let!(:articles) { create_list(:article, 3, user: user) }
    it '記事一覧が表示される' do
        visit root_path
        articles.each do |article|
          expect(page).to have_css('.article_text_content', text: article.content)
        end
    end
end