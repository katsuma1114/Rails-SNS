# frozen_string_literal: true

module UserDecorator
    def following_count #フォローしている数をカウント
        followings.count
    end
    
    def follower_count #フォローされている数をカウント
        followers.count
    end
    
    def article_count #記事を投稿した数をカウント
        articles.count
    end

    def avatar_image #アバターがあればそれを、なければno-img-avatar.jpgを返す
      if profile&.avatar&.attached?
        profile.avatar
      else
        "no-user-image.png"
      end
    end
end
