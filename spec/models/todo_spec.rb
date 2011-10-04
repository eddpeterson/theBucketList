require 'spec_helper'

describe Todo, "Save model" do
    
  it "should save model with title and due date" do
    todo = Factory(:todo)
    todo.save.should be true
  end
  
  it "should save model with frame" do
    todo = Factory(:todo)
    todo.frame = :family
    todo.save.should be true
  end
  
  it "should validate presence of title" do
    todo = Factory(:todo)
    todo.title = nil
    todo.save.should be false
  end
  
  it "should return past todos" do
    todo_past = Factory(:todo, :due_date => Date.yesterday)
    todo_current = Factory(:todo, :due_date => Date.today)
    Todo.stub!(:all).and_return([todo_past, todo_current])
    
    Todo.past_todos.should include(todo_past)
    Todo.past_todos.should_not include(todo_current)
  end
  
  it "should return current todos" do
    todo_past = Factory(:todo, :due_date => Date.yesterday)
    todo_current_first = Factory(:todo, :due_date => Date.today)
    todo_current_last = Factory(:todo, :due_date => Date.today >> 10) #next 10 months
    todo_future = Factory(:todo, :due_date => Date.today >> 11) #next 11 months
    
    Todo.stub!(:all).and_return([todo_past, todo_current_first, todo_current_last, todo_future])
    
    Todo.current_todos.should_not include(todo_past)
    Todo.current_todos.should include(todo_current_first)
    Todo.current_todos.should include(todo_current_last)
    Todo.current_todos.should_not include(todo_future)
  end
  
  it "should return future todos" do 
    todo_current_last = Factory(:todo, :due_date => Date.today >> 10) #next 10 months
    todo_future = Factory(:todo, :due_date => Date.today >> 11) #next 11 months
    
    Todo.stub!(:all).and_return([todo_current_last, todo_future])
    
    Todo.future_todos.should_not include(todo_current_last)
    Todo.future_todos.should include(todo_future)  
  end
  
  it "should return done todos percentage" do
    Factory(:todo, :status => "done")
    Factory(:todo, :status => "done")
    Factory(:todo, :status => nil)
    Factory(:todo, :status => "undone")
      
    Todo.done_todos_percentage.should == 50
  end
  
  it "should return done todos percentage in human readable format" do
    Factory(:todo, :status => "done")
    Factory(:todo, :status => nil)
    Factory(:todo, :status => "undone")
    
    Todo.done_todos_percentage.should == 33
  end
  
  it "should return zero progress when empty todos" do 
    Todo.done_todos_percentage.should == 0    
  end
  
  it "should set due date to next 10months for new todo" do
    todo = Todo.create_new!("title 1", "family")
    todo.due_date.should == Date.today >> 10
  end
    
end
