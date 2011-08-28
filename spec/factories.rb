FactoryGirl.define do

  factory :todo do 
    title 'todo title'
    due_date Time.now
    frame "frame"
  end
  
end
