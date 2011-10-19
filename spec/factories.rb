FactoryGirl.define do

  factory :todo do 
    title 'todo title'
    due_date Time.now
    frame "family"
  end
  
  factory :user do
    id "123"
    password "password"
    email "user@example.com"
    token "token123"
    name "Ryan Nugent-Hopkins"
    first_name "Ryan"
    last_name "Nugent-Hopkins"
    todos = []
  end
  
end
