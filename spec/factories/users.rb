FactoryBot.define do
    factory :user do
        email { Faker::Internet.email }
        password { 'password' }
        user_name { Faker::Name.name }

        trait :with_profile do
            after :build do |user|
                build(:profile, user: user)
            end
        end
    end
end