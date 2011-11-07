FactoryGirl.define do
  
  factory :user do
    id "123"
    email "user@example.com"
    token "token123"
    name "Ryan Nugent-Hopkins"
    first_name "Ryan"
    last_name "Nugent-Hopkins"
    todos = []
  end
  
end
