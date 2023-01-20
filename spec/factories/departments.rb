FactoryBot.define do
  factory :department do
    sequence(:name, 10) { |n| "department#{n}" }
  end
end