FactoryBot.define do
  factory :authorization do
    provider 'MyProvider'
    uid '123456'
    user nil
  end
end
