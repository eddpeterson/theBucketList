require 'spec_helper'

describe Todo do
  
  let (:user) { Factory(:user) }
  
  it { should validate_presence_of(:title) }
  
  it "should save model" do
    user.todos << Todo.get_new("Travel to Hawaii", "family")
    user.save.should be_true
  end
  
  it "should save model with updated frame" do
    todo = Todo.get_new("Travel to Hawaii", "family")
    user.todos << todo
    user.save.should be_true
    
    savedTodo = user.todos.find(todo.id)
    savedTodo.frame = "personal"
    user.save.should be true
    
    user.todos.find(todo.id).frame.should == "personal"
  end
 
  it "should set due date to next 10months for new todo" do
    todo = Todo.get_new("Travel to Hawaii", "family")
    todo.due_date.should == Date.today >> 10
  end
    
end
