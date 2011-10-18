FactoryGirl.define do

  factory :todo do 
    title 'todo title'
    due_date Time.now
    frame "family"
  end
  
  
end
