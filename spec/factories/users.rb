FactoryBot.define do
  factory :user do
    name               "test"
    sequence(:username) { |n| "testtest#{n}" }
    sequence(:email)    { |n| "teST#{n}@example.com" }
    password           "password"
  end
end
