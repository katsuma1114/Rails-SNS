# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  user_name              :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :user_name, uniqueness: true
  validates :user_name, presence: true

  has_one :profile, dependent: :destroy

  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following

  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :articles, dependent: :destroy

  has_many :likes, dependent: :destroy

  has_many :favorite_articles, through: :likes, source: :article

  has_many :comments, dependent: :destroy

  def prepare_profile
    profile || build_profile
  end

  def avatar_image #アバターがあればそれを、なければno-img-avatar.jpgを返す
    if profile&.avatar&.attached?
      profile.avatar
    else
      "no-user-image.png"
    end
  end

  def has_liked?(article)#いいねしてるかしてないか判断
    likes.exists?(article_id: article.id)
  end

  def following_count #フォローしている数をカウント
    followings.count
  end

  def follower_count #フォローされている数をカウント
    followers.count
  end

  def article_count #記事を投稿した数をカウント
    articles.count
  end

  def has_followed?(user) #されているか判断
    following_relationships.exists?(following_id: user.id)
  end

  def has_written?(article) #自分の記事かどうか判断
    articles.exists?(id: article.id)
  end

  def follow!(user) #フォロー
    user_id = get_user_id(user)

    following_relationships.create!(following_id: user_id)
  end

  def unfollow!(user) #アンフォロー
    user_id = get_user_id(user)

    relation = following_relationships.find_by!(following_id: user_id)
    relation.destroy!
  end

  private
  def get_user_id(user)
    if user.is_a?(User)
      user.id
    else
      user
    end
  end
end
