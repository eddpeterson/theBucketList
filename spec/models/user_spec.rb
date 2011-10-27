require 'spec_helper'

describe User do
  
  let (:user) { Factory(:user) }
  
  
  it "should save user todos" do
    user.save.should be_true
  end
  
  it "should return past todos" do
    todo_past = Todo.get_new("Graduate Master in CS", "personal")
    todo_past.due_date = Date.yesterday
    user.todos << todo_past
     
    todo_current = Todo.get_new("Travel to Hawaii", "family")
    todo_current.due_date = Date.today
    user.todos << todo_current
    
    user.past_todos.should include(todo_past)
    user.past_todos.should_not include(todo_current)
   end

   it "should return current todos" do
     todo_past = Todo.get_new("Graduate Master in CS", "personal")
     todo_past.due_date = Date.yesterday
     user.todos << todo_past
     
     todo_current_first = Todo.get_new("Travel to Gran Canaria in winter", "family") 
     todo_current_first.due_date = Date.today
     user.todos << todo_current_first
     
     todo_current_last = Todo.get_new("Travel to Gran Canaria in summer", "family")
     todo_current_last.due_date = Date.today >> 10 #next 10 months
     user.todos << todo_current_last
     
     todo_future = Todo.get_new("Travel to Hawaii", "family")
     todo_future.due_date = Date.today >> 11 #next 11 months
     user.todos << todo_future
     

     user.current_todos.should_not include(todo_past)
     user.current_todos.should include(todo_current_first)
     user.current_todos.should include(todo_current_last)
     user.current_todos.should_not include(todo_future)
   end

   it "should return future todos" do 
     todo_current_last = Todo.get_new("Travel to Gran Canaria in summer", "family")
     todo_current_last.due_date = Date.today >> 10 #next 10 months
     user.todos << todo_current_last
     
     todo_future = Todo.get_new("Travel to Hawaii", "family")
     todo_future.due_date = Date.today >> 11 #next 11 months
     user.todos << todo_future
     
     user.future_todos.should_not include(todo_current_last)
     user.future_todos.should include(todo_future)  
   end

   it "should return done todos percentage" do
     user.todos << Todo.get_new("Travel to Gran Canaria in summer", "family")
     
     todo_done = Todo.get_new("Travel to Furteventura", "family")
     todo_done.status = "done"
     user.todos << todo_done
     
     user.done_todos_percentage.should == 50
   end

   it "should return done todos percentage in human readable format (2 numbers only)" do
     user.todos << Todo.get_new("Travel to Gran Canaria in winter", "family")
     user.todos << Todo.get_new("Travel to Gran Canaria in summer", "family")
     
     todo_done = Todo.get_new("Travel to Fuerteventura", "family")
     todo_done.status = "done"
     user.todos << todo_done
     
     user.done_todos_percentage.should == 33
   end

   it "should return zero progress when empty todos" do 
     user.done_todos_percentage.should == 0    
   end
  
end
