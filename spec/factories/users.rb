FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password '123456789'
    password_confirmation '123456789'
    confirmed_at Time.now - 1.days
  end
end
