FactoryBot.define do
    factory :user,class: User do
        name { "user"}
        email { "user@example.com" }
        password { "password"}
        password_confirmation { "password" }
        admin { true }
        activated { true }
        activated_at { Time.zone.now }
    end

    factory :other_user,class: User do
        name { "other_user"}
        email { "other_user@example.com" }
        password { "password"}
        password_confirmation { "password" }
        admin { false }
        activated { true }
        activated_at { Time.zone.now }
    end

    factory :non_admin,class: User do
        name { "non_admin"}
        email { "non_admin@example.com" }
        password { "password"}
        password_confirmation { "password" }
        admin { false }
        activated { true }
        activated_at { Time.zone.now }
    end

    factory :add_user,class: User do
        name { Faker::Name.name}
        email { Faker::Internet.email }
        password { "password"}
        password_confirmation { "password" }
        admin { false }
        activated { true }
        activated_at { Time.zone.now }
    end


end