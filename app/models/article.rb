# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Article < ApplicationRecord
    has_many_attached :images #画像を複数枚保存
    has_many :likes, dependent: :destroy
    has_many :comments,dependent: :destroy
    
    belongs_to :user
    
    validates :images, presence: true
    validate :image_length, :image_type

    validates :content, presence: true

    #日付を表記する
    def display_created_at
        I18n.l(self.created_at, format: :long)
    end

     private

     def image_length
        if images.length > 5
            images = nil
            errors.add(:images, 'は5枚以内にしてください')
        end
     end

     def image_type
        images.each do |image|
          if !image.blob.content_type.in?(%('image/jpeg image/png'))
            errors.add(:images, 'はjpegまたはpng形式でアップロードしてください')
          end
        end
    end
end
