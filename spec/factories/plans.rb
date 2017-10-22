FactoryGirl.define do
  factory :plan do
    sequence(:title) { |n| "Plan_#{n}" }
  end
end
