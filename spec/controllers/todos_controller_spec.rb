# require 'spec_helper'
# 
# describe TodosController do
# 
#   #before(:each) do
#   #@request.env['HTTP_REFERER'] = 'http://localhost' # otherwise you get error: No HTTP_REFERER was set in the request to this action, so redirect_to :back could not be called successfully. If this is a test, make sure to specify request.env["HTTP_REFERER"].
#   #end
# 
#   # it "should return new todo object on creation" do
#   #   Todo.should_receive(:new)
#   #   get :new
#   # end
#   # 
#   # it "should save new todo object with passed in fields" do
#   #   Todo.stub!(:new).and_return(@todo = mock_model(Todo, :save => true, :title => "Travel to Hawaii"))
#   #   Todo.should_receive(:new).with("title"=>"Travel to Hawaii")
#   #   @todo.should_receive(:save).and_return(true)
#   #   post :create, params[:title]=>"Travel to Hawaii"
#   # end
# 
#   context "should return sorted " do
#     it "personal todos" do
#       t1 = Factory(:todo, :frame => "personal", :title => "First", :frame_order_number => 1)
#       t2 = Factory(:todo, :frame => "personal", :title => "Second", :frame_order_number => 2)
#       t3 = Factory(:todo, :frame => "other")
#       group_and_sort_by_frame [t2,t1,t3], [t1,t2], :personal_todos
#     end
#     it "family todos" do
#       t1 = Factory(:todo, :frame => "family", :title => "First", :frame_order_number => 1)
#       t2 = Factory(:todo, :frame => "family", :title => "Second", :frame_order_number => 2)
#       t3 = Factory(:todo, :frame => "other")
#       group_and_sort_by_frame [t2,t1,t3], [t1,t2], :family_todos
#     end
#     it "friends todos" do
#       t1 = Factory(:todo, :frame => "friends", :title => "First", :frame_order_number => 1)
#       t2 = Factory(:todo, :frame => "friends", :title => "Second", :frame_order_number => 2)
#       t3 = Factory(:todo, :frame => "other")
#       group_and_sort_by_frame [t2,t1,t3], [t1,t2], :friends_todos
#     end    
#     it "work todos" do
#       t1 = Factory(:todo, :frame => "work", :title => "First", :frame_order_number => 1)
#       t2 = Factory(:todo, :frame => "work", :title => "Second", :frame_order_number => 2)
#       t3 = Factory(:todo, :frame => "other")
#       group_and_sort_by_frame [t2,t1,t3], [t1,t2], :work_todos
#     end
#     it "social todos" do
#       t1 = Factory(:todo, :frame => "social", :title => "First", :frame_order_number => 1)
#       t2 = Factory(:todo, :frame => "social", :title => "Second", :frame_order_number => 2)
#       t3 = Factory(:todo, :frame => "other")
#       group_and_sort_by_frame [t2,t1,t3], [t1,t2], :social_todos
#     end
#     def group_and_sort_by_frame unsorted, sorted, name
#       Todo.stub!(:all).and_return(unsorted)
#       get :index
#       assigns(name).should eq(sorted)    
#     end
# 
#   end
# 
#   
# 
#   it "Should remove todo" do
#     todo = Todo.get_new("Travel to Hawaii", "family")
#     user.todos << todo
#     delete "#{todos_path}/#{todo.id}"
#     visit todos_path
#     page.should_not have_content("#{todo.title}")
#   end
#   
#   it "should set sorting and frame" do
#     t1 = Todo.create!(:title => "title 1", :frame_order_number => 1, :frame => "work")
#     t2 = Todo.create!(:title => "title 2", :frame_order_number => 2, :frame => "personal")
#     t3 = Todo.create!(:title => "title 3", :frame_order_number => 3, :frame => "social")
#     
#     post todos_set_sorting_path, {:sorted_todos => [t3.id, t2.id, t1.id], :frame => "family"}
#     
#     Todo.find(t1.id).frame_order_number == 3
#     Todo.find(t2.id).frame_order_number == 2
#     Todo.find(t3.id).frame_order_number == 1
#     Todo.find(t1.id).frame == "family"
#     Todo.find(t2.id).frame == "family"
#     Todo.find(t3.id).frame == "family"
#   end
#   
#   it "should ignore set sorting for empty array" do
#     post todos_set_sorting_path, {:sorted_todos => [], :frame => "family"}
#   end
# 
# end
