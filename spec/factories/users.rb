FactoryBot.define do
    factory :user do
        email { Faker::Internet.email }
        password { 'password' }
        user_name { Faker::Name.name }
    end
end