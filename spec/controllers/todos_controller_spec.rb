require 'spec_helper'

describe TodosController do
  
  #before(:each) do
    #@request.env['HTTP_REFERER'] = 'http://localhost' # otherwise you get error: No HTTP_REFERER was set in the request to this action, so redirect_to :back could not be called successfully. If this is a test, make sure to specify request.env["HTTP_REFERER"].
  #end
  
  it "should return new todo object on creation" do
    Todo.should_receive(:new)
    get :new
  end
  
  it "should save new todo object with passed in fields" do
    Todo.stub!(:new).and_return(@todo = mock_model(Todo, :save => true, :title => "Travel to Hawaii"))
    Todo.should_receive(:new).with("title"=>"Travel to Hawaii")
    @todo.should_receive(:save).and_return(true)
    post :create, :todo => {:title=>"Travel to Hawaii"}
  end
  
  it "should return sorted no frame todos" do
    t1 = Factory(:todo, :frame => nil, :title => "First", :frame_order_number => 1)
    t2 = Factory(:todo, :frame => nil, :title => "Second", :frame_order_number => 2)
    todos = [t2, t1]
    Todo.stub!(:all).and_return(todos)
    get :index
    assigns(:no_frame_todos).should eq([t1, t2])
  end
    
end
