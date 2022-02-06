# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Profile < ApplicationRecord
    belongs_to :user
    has_one_attached :avatar
    
    validates :avatar, presence: true
    validate :image_type

    private
    def image_type
        if !avatar.blob.content_type.in?(%('image/jpeg image/png'))
          errors.add(:avatar, 'はjpegまたはpng形式でアップロードしてください')
        end
    end
end
