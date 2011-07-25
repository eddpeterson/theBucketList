require 'spec_helper'

describe Todo do
  context "Save model" do
    
    it "with title and due date" do
      todo = Factory(:todo)
      todo.save.should be true
    end
    
  end
end
