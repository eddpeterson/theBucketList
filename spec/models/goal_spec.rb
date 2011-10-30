require 'spec_helper'

describe Goal do
  
  let (:user) { Factory(:user) }
  
  it { should validate_presence_of(:title) }
  
  it "should save model" do
    user.goals << Goal.get_new("Travel to Hawaii", "family")
    user.save.should be_true
  end
  
  it "should save model with updated frame" do
    goal = Goal.get_new("Travel to Hawaii", "family")
    user.goals << goal
    user.save.should be_true
    
    savedGoal = user.goals.find(goal.id)
    savedGoal.frame = "personal"
    user.save.should be true
    
    user.goals.find(goal.id).frame.should == "personal"
  end
 
  it "should set due date to next 10months for new goal" do
    goal = Goal.get_new("Travel to Hawaii", "family")
    goal.due_date.should == Date.today >> 10
  end
    
end
