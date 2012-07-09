FactoryGirl.define do
  sequence(:email) {|n| "user#{n}@greenback.com"}
  sequence(:title) {|n| "title#{n}"}
  sequence(:location) {|n| "location#{n}"}
  
  factory :user do
    email { generate :email}
    password "password"
  end
  
  factory :issue do
    title {generate :title}
    issue_content "test content"
    association :user
  end
  
  factory :comment do
    body_comments "test body comment"
    location { generate :location}
    association :user
    association :issue
  end
end
