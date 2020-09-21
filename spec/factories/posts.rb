FactoryBot.define do
  factory :post do
    content { "test" }
    category_id { 1 }
    association :user
    association :category
  end
end
