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
  
  it "should return true for .past? if due date is in past" do
    goal = Goal.get_new("Travel to Hawaii", "family")
    goal.due_date = Date.yesterday
    goal.past?.should be_true
  end
  
  it "should return ture for .current? if due date is today" do
    goal = Goal.get_new("Travel to Hawaii", "family")
    goal.due_date = Date.today
    goal.current?.should be_true    
  end
  
  it "should return true for .future? if due date is greater than 10 months" do
    goal = Goal.get_new("Travel to Hawaii", "family")
    goal.due_date = Date.today >> 11
    goal.future?.should be_true        
  end
    
end
