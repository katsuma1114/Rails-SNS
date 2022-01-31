# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  user_name              :string
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

  def following_count
    followings.count
  end

  def follower_count
    followers.count
  end

  def has_followed?(user)
    following_relationships.exists?(following_id: user.id)
  end

  def follow!(user)
    user_id = get_user_id(user)

    following_relationships.create!(following_id: user_id)
  end

  def unfollow!(user)
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
