FactoryGirl.define do
  factory :book do
    sequence(:google_book_id) { |n| "My_google_book_#{n}" }
  end
end
