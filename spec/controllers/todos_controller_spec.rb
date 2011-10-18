require 'spec_helper'

describe TodosController do

  before (:each) do
    #before(:each) do
      #puts request.methods.sort
      #request.env["devise.mapping"] = Devise.mappings[:user]
      user = User.create!(:id => "1637261457", :token => "token")#Factory.create(:user)
      #user.confirm!
      user.save
      sign_in user 
    #end
  end

  it "should have a current_user" do
    subject.current_user.should_not be_nil
    puts "id...................."
    puts subject.current_user.id
    
    visit friends_path
    save_and_open_page
  end
  #before(:each) do
  #@request.env['HTTP_REFERER'] = 'http://localhost' # otherwise you get error: No HTTP_REFERER was set in the request to this action, so redirect_to :back could not be called successfully. If this is a test, make sure to specify request.env["HTTP_REFERER"].
  #end

  # it "should return new todo object on creation" do
  #   Todo.should_receive(:new)
  #   get :new
  # end
  # 
  # it "should save new todo object with passed in fields" do
  #   Todo.stub!(:new).and_return(@todo = mock_model(Todo, :save => true, :title => "Travel to Hawaii"))
  #   Todo.should_receive(:new).with("title"=>"Travel to Hawaii")
  #   @todo.should_receive(:save).and_return(true)
  #   post :create, params[:title]=>"Travel to Hawaii"
  # end

  context "should return sorted " do
    it "personal todos" do
      t1 = Factory(:todo, :frame => "personal", :title => "First", :frame_order_number => 1)
      t2 = Factory(:todo, :frame => "personal", :title => "Second", :frame_order_number => 2)
      t3 = Factory(:todo, :frame => "other")
      group_and_sort_by_frame [t2,t1,t3], [t1,t2], :personal_todos
    end
    it "family todos" do
      t1 = Factory(:todo, :frame => "family", :title => "First", :frame_order_number => 1)
      t2 = Factory(:todo, :frame => "family", :title => "Second", :frame_order_number => 2)
      t3 = Factory(:todo, :frame => "other")
      group_and_sort_by_frame [t2,t1,t3], [t1,t2], :family_todos
    end
    it "friends todos" do
      t1 = Factory(:todo, :frame => "friends", :title => "First", :frame_order_number => 1)
      t2 = Factory(:todo, :frame => "friends", :title => "Second", :frame_order_number => 2)
      t3 = Factory(:todo, :frame => "other")
      group_and_sort_by_frame [t2,t1,t3], [t1,t2], :friends_todos
    end    
    it "work todos" do
      t1 = Factory(:todo, :frame => "work", :title => "First", :frame_order_number => 1)
      t2 = Factory(:todo, :frame => "work", :title => "Second", :frame_order_number => 2)
      t3 = Factory(:todo, :frame => "other")
      group_and_sort_by_frame [t2,t1,t3], [t1,t2], :work_todos
    end
    it "social todos" do
      t1 = Factory(:todo, :frame => "social", :title => "First", :frame_order_number => 1)
      t2 = Factory(:todo, :frame => "social", :title => "Second", :frame_order_number => 2)
      t3 = Factory(:todo, :frame => "other")
      group_and_sort_by_frame [t2,t1,t3], [t1,t2], :social_todos
    end
    def group_and_sort_by_frame unsorted, sorted, name
      Todo.stub!(:all).and_return(unsorted)
      get :index
      assigns(name).should eq(sorted)    
    end

  end


  # it "should save with new frame" do
  #     @todo = mock_model(Todo, :frame => "none", :frame_order_number => 1)
  #     Todo.stub!(:find).and_return(@todo)
  #     #todo.should_receive(:frame).with("personal")
  #     #@todo.should_receive(:save).and_return(true)
  #     #@todo.should_receive(:frame).exactly(1).times
  #     post :set_frame, :id => @todo.id, :frame => "personal" 
  #     assigns(@todo.frame).should eq("personal")
  #   end
  
  

end
