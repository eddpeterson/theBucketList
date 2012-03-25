require 'spec_helper'

describe User do
  
  let (:user) { FactoryGirl.create(:user) }
  
  
  it "should save user goals" do
    user.save.should be_true
  end
  
  it "should return past goals" do
    
    goal_2001  = Goal.get_new("Graduate Master in CS", "personal")
    goal_2001.due_date = Date.new(2001,1,1) 
    user.goals << goal_2001
    
    goal_2011  = Goal.get_new("Graduate Master in CS", "personal")
    goal_2011.due_date = Date.new(2011,1,1) 
    user.goals << goal_2011
    
    goal_yesterday = Goal.get_new("Graduate Master in CS", "personal")
    goal_yesterday.due_date = Date.yesterday
    user.goals << goal_yesterday
     
    goal_current = Goal.get_new("Travel to Hawaii", "family")
    goal_current.due_date = Date.today
    user.goals << goal_current
    
    user.past_goals.count.should == 3
    user.past_goals[0].should == goal_yesterday
    user.past_goals[1].should == goal_2011
    user.past_goals[2].should == goal_2001
    user.past_goals.should_not include(goal_current)
  end

   it "should return current goals" do
     goal_past = Goal.get_new("Graduate Master in CS", "personal")
     goal_past.due_date = Date.yesterday
     user.goals << goal_past
     
     goal_current_last = Goal.get_new("Travel to Gran Canaria in summer", "family")
     goal_current_last.due_date = Date.today >> 10 #next 10 months
     user.goals << goal_current_last

     goal_current_first = Goal.get_new("Travel to Gran Canaria in winter", "family") 
     goal_current_first.due_date = Date.today
     user.goals << goal_current_first
     
     goal_future = Goal.get_new("Travel to Hawaii", "family")
     goal_future.due_date = Date.today >> 11 #next 11 months
     user.goals << goal_future
     
     user.current_goals.count.should == 2
     user.current_goals[0].should  == goal_current_first
     user.current_goals[1].should  == goal_current_last
     user.current_goals.should_not include(goal_past)
     user.current_goals.should_not include(goal_future)
   end

   it "should return future goals" do 
     goal_current_last = Goal.get_new("Travel to Gran Canaria in summer", "family")
     goal_current_last.due_date = Date.today >> 10 #next 10 months
     user.goals << goal_current_last
     
     goal_future2120 = Goal.get_new("Travel to Hawaii", "family")
     goal_future2120.due_date = Date.new(2120, 1, 1)
     user.goals << goal_future2120
     
     goal_future = Goal.get_new("Travel to Hawaii", "family")
     goal_future.due_date = Date.today >> 11 #next 11 months
     user.goals << goal_future

     user.future_goals.count.should == 2
     user.future_goals[0].should  == goal_future
     user.future_goals[1].should  == goal_future2120
     user.future_goals.should_not include(goal_current_last)
   end

   it "should calculate goals percentage" do
     user.goals << Goal.get_new("Travel to Gran Canaria in summer", "family")
     
     goal_done = Goal.get_new("Travel to Furteventura", "family")
     goal_done.status = "done"
     user.goals << goal_done
     
     user.calculate_goals_percentage.should == 50
   end

   it "should return calculate goals percentage in human readable format (2 numbers only)" do
     user.goals << Goal.get_new("Travel to Gran Canaria in winter", "family")
     user.goals << Goal.get_new("Travel to Gran Canaria in summer", "family")
     
     goal_done = Goal.get_new("Travel to Fuerteventura", "family")
     goal_done.status = "done"
     user.goals << goal_done
     
     user.calculate_goals_percentage.should == 33
   end

   it "should return zero progress when empty goals" do 
     user.calculate_goals_percentage.should == 0    
   end
   
   it "should return append to id for past goals" do
     old_goal = Goal.get_new("Old goal", "family")
     old_goal.due_date = Date.new(2001, 1, 1)
     user.goals << old_goal
     
     append_to_goal = Goal.get_new("Append to goal", "family")
     append_to_goal.due_date = Date.yesterday
     user.goals << append_to_goal
     
     goal = Goal.get_new("Goal", "family")
     goal.due_date = Date.yesterday - 1 # - 1 day
     user.goals << goal
     
     user.append_to_goal_id(goal).should be(append_to_goal.id)
   end
   
   it "should return append to id for current goals" do
     goal_next_month = Goal.get_new("Goal", "family")
     goal_next_month.due_date = Date.today >> 1 # + 1 month
     user.goals << goal_next_month

     append_to_goal = Goal.get_new("Append to goal", "family")
     append_to_goal.due_date = Date.today
     user.goals << append_to_goal

     goal = Goal.get_new("Goal", "family")
     goal.due_date = Date.today + 1 # + 1 day
     user.goals << goal
     
     user.append_to_goal_id(goal).should be(append_to_goal.id)
   end
   
   it "should return append to id for future goals" do
     goal_next_year = Goal.get_new("Goal", "family")
     goal_next_year.due_date = Date.today >> 12 # + 12 month
     user.goals << goal_next_year
     
     append_to_goal = Goal.get_new("Append to goal", "family")
     append_to_goal.due_date = Date.today >> 11 + 1# + 11 month + 1 day
     user.goals << append_to_goal

     goal = Goal.get_new("Goal", "family")
     goal.due_date = Date.today >> 11 + 2 # + 11 month + 2 days
     user.goals << goal
     
     user.append_to_goal_id(goal).should be(append_to_goal.id)
   end
   
   describe "should update completed goals satatus" do
     it "when goal status is changed" do
       goal = Goal.get_new("Goal", "family")
       user.goals << goal       
       user.set_goal_status(goal.id, "done")
       user.completed_goals_percentage.should == 100
     end
     it "when adding new goal" do
       goal = Goal.get_new("Goal", "family")
       user.add_goal(goal)
       goal_done = Goal.get_new("Goal", "family")
       goal_done.status = "done"
       user.add_goal(goal_done)
       
       user.completed_goals_percentage.should == 50
     end
     it "when removing new goal" do
       goal = Goal.get_new("Goal", "family")
       user.add_goal(goal)
       goal_done = Goal.get_new("Goal", "family")
       goal_done.status = "done"
       user.add_goal(goal_done)
       
       user.remove_goal(goal.id)
       user.completed_goals_percentage.should == 100
     end
   end
   
   it "should update facebook info" do
     facebook_info = {
       'email' => 'updated@gmail.com',
       'name' => 'updated name',
       'last_name' => 'updated last name',
       'first_name' => 'updated first name'
     }
     user.stub!(:facebook_info).with(user.id, user.token).and_return facebook_info
     
     user.update_facebook_info
     
     user.email.should == 'updated@gmail.com'
     user.name.should == 'updated name'
     user.last_name.should == 'updated last name'
     user.first_name.should == 'updated first name'
   end
   
   it "should return facebook friends" do
     friend = FactoryGirl.create(:user)
     
     user.stub!(:friends_ids).with(user.id, user.token).and_return [friend.id]
     
     user.friends.should include(friend)
   end
   
   it "should set new goal on top with frame_order_number equals to 1" do
     user.add_goal(Goal.get_new("Goal 1", "family"))
     goal = Goal.get_new("Goal 2", "family")
     user.add_goal(goal)
     goal.frame_order_number.should == 1
   end
   
   it "should not forget previously set goals order when adding new goal to top" do
     goal1 = Goal.get_new("Goal 1", "family")
     user.add_goal(goal1)
     goal2 = Goal.get_new("Goal 2", "family")
     user.add_goal(goal2)
     goal3 = Goal.get_new("Goal 3", "family")
     user.add_goal(goal3)
    
     user.goals[0].frame_order_number.should == 3
     user.goals[1].frame_order_number.should == 2
     user.goals[2].frame_order_number.should == 1
   end
  
end
