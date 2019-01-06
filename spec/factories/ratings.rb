FactoryBot.define do
  factory :rating do
    association :order_item, factory: :order_item
    sequence(:title) { "MyString" }
    description { "MyText" }
    score { 1 }
    order_item { nil }
  end
end
