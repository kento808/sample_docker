FactoryBot.define do
  factory :post do
    content { "test" }
    association :user
  end
end
