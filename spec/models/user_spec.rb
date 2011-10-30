require 'spec_helper'

describe User do
  
  let (:user) { Factory(:user) }
  
  
  it "should save user goals" do
    user.save.should be_true
  end
  
  it "should return past goals" do
    goal_past = Goal.get_new("Graduate Master in CS", "personal")
    goal_past.due_date = Date.yesterday
    user.goals << goal_past
     
    goal_current = Goal.get_new("Travel to Hawaii", "family")
    goal_current.due_date = Date.today
    user.goals << goal_current
    
    user.past_goals.should include(goal_past)
    user.past_goals.should_not include(goal_current)
   end

   it "should return current goals" do
     goal_past = Goal.get_new("Graduate Master in CS", "personal")
     goal_past.due_date = Date.yesterday
     user.goals << goal_past
     
     goal_current_first = Goal.get_new("Travel to Gran Canaria in winter", "family") 
     goal_current_first.due_date = Date.today
     user.goals << goal_current_first
     
     goal_current_last = Goal.get_new("Travel to Gran Canaria in summer", "family")
     goal_current_last.due_date = Date.today >> 10 #next 10 months
     user.goals << goal_current_last
     
     goal_future = Goal.get_new("Travel to Hawaii", "family")
     goal_future.due_date = Date.today >> 11 #next 11 months
     user.goals << goal_future
     

     user.current_goals.should_not include(goal_past)
     user.current_goals.should include(goal_current_first)
     user.current_goals.should include(goal_current_last)
     user.current_goals.should_not include(goal_future)
   end

   it "should return future goals" do 
     goal_current_last = Goal.get_new("Travel to Gran Canaria in summer", "family")
     goal_current_last.due_date = Date.today >> 10 #next 10 months
     user.goals << goal_current_last
     
     goal_future = Goal.get_new("Travel to Hawaii", "family")
     goal_future.due_date = Date.today >> 11 #next 11 months
     user.goals << goal_future
     
     user.future_goals.should_not include(goal_current_last)
     user.future_goals.should include(goal_future)  
   end

   it "should return done goals percentage" do
     user.goals << Goal.get_new("Travel to Gran Canaria in summer", "family")
     
     goal_done = Goal.get_new("Travel to Furteventura", "family")
     goal_done.status = "done"
     user.goals << goal_done
     
     user.done_goals_percentage.should == 50
   end

   it "should return done goals percentage in human readable format (2 numbers only)" do
     user.goals << Goal.get_new("Travel to Gran Canaria in winter", "family")
     user.goals << Goal.get_new("Travel to Gran Canaria in summer", "family")
     
     goal_done = Goal.get_new("Travel to Fuerteventura", "family")
     goal_done.status = "done"
     user.goals << goal_done
     
     user.done_goals_percentage.should == 33
   end

   it "should return zero progress when empty goals" do 
     user.done_goals_percentage.should == 0    
   end
  
end
