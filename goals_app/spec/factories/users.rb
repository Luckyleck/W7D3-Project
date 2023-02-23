FactoryBot.define do
    factory :user do
        username { Faker::Internet.unique.user_name }
        password { "password" }

        factory :user_hw do
            username { "hello_world" }
        end
    end
end