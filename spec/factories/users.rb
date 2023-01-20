FactoryBot.define do
  factory :user do
    sequence(:email, 100) { |n| "hello#{n}@mysterlunch.com" }
    password { "123456" }
    admin { true }
  end
end