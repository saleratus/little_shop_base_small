FactoryBot.define do
  factory :rating do
    association :order_item, factory: :order_item
    sequence(:title) { |n| "Rating Title #{n}" }
    sequence(:description) { |n| "This item is a big #{n}" }
    score { 3 }
  end
end
