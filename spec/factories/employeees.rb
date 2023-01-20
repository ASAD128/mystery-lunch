FactoryBot.define do
  factory :employee do
    sequence(:name, 100) { |n| "employee#{n}" }
  end
end