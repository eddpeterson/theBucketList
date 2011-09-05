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
  
  
  
    
end
