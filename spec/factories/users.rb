FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    name 'Ivan'
    avatar File.open("#{Rails.root}/.rspec")
    password '123456789'
    password_confirmation '123456789'
    confirmed_at Time.now - 1.days

    factory :invalid_user do
      email nil
      name nil
      avatar nil
      password nil
      password_confirmation nil
    end
  end
end
