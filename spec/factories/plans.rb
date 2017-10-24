FactoryBot.define do
  factory :plan do
    sequence(:title) { |n| "Plan_title_#{n}" }
    sequence(:description) { |n| "Plan_description_#{n}" }
    user

    factory :invalid_plan do
      title nil
      description nil
      user nil
    end
  end
end
