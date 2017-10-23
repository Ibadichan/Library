FactoryGirl.define do
  factory :plan do
    sequence(:title) { |n| "Plan_title_#{n}" }
    sequence(:description) { |n| "Plan_description_#{n}" }
    user
  end
end
