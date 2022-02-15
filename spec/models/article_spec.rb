require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:user) { create(:user) }

  context '画像と内容が入力されてる場合' do
    let!(:article) { build(:article, user: user) }

    it '記事を保存することができる' do
      expect(article).to be_valid
    end
  end

  context '画像が6枚以上の場合' do
    let!(:article) { build(:article, user: user) }

    before do
      6.times do
        article.images.attach(io: File.open('app/assets/images/no-user-image.png'), filename: 'no-user-image.png')
      end

      article.save
    end

    it '記事を保存できない' do
      expect(article.errors.messages[:images][0]).to eq('は5枚以内にしてください')
    end
  end
end

