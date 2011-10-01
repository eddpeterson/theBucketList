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
    todo = Factory(:todo, :due_date => Date.yesterday)
    todo_current = Factory(:todo, :due_date => Date.today)
    Todo.stub!(:all).and_return([todo, todo_current])
    
    Todo.past_todos.should include(todo)
    Todo.past_todos.should_not include(todo_current)

    
  end
    
end
