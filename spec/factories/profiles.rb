FactoryBot.define do
    factory :profile do
        after(:build) do |profile|
            profile.avatar.attach(io: File.open('app/assets/images/no-user-image.png'), filename: 'no-user-image.png')
        end
    end
end 