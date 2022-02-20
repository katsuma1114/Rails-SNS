# Rails Sns
This project is a simple social networking application made with Ruby on Rails.
This application is only available for smartphones.

* database (PostgreSQL)
* image file upload (AWS S3)
* deploy (heroku)

# Features
This application allows you to post images and keep a daily record of your life.

UI is inspired by Instagram.



# Users table
|Column|Type|Options|
|------|----|-------|
|name|string|not null|
|email|string|not null|
|password|string|nut null|
## Association
* has_many :articles
* has_many :comments
* has_many :likes
* has_many :favorite_articles
* has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship'
* has_many :followings, through: :following_relationships
* has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship'
* has_many :followers, through: :follower_relationships
* has_one :profile

# Articles table
|Column|Type|Options|
|------|----|-------|
|content|text|not null|
## Association
* belongs_to :user

* has_many_attached :images (Active Storage)
* has_many :comments
* has_many :likes

# Comments table
|Column|Type|Options|
|------|----|-------|
|content|text|not null|
## Association
* belongs_to :user
* belongs_to :article

# Likes table
## Association
* belongs_to :user
* belongs_to :article

# Profiles table
## Association
* belongs_to :user
* has_one_attached :avatar (Active storage)

# Relationship table
## Association
* belongs_to :follower, class_name: 'User'
* belongs_to :following, class_name: 'User'
