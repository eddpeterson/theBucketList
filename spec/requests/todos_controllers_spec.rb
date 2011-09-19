require 'spec_helper'


# Read more on capybara here:
# https://github.com/jnicklas/capybara

describe "TodosControllers" do

  it "Add new item" do
    todo = Factory(:todo)
    visit new_todo_path
    fill_in "Title", :with => todo.title
    fill_in "Due date", :with => todo.due_date
    click_button "Add"
    current_path.should eq(todos_path)
    page.should have_content("#{todo.title} added to your bucket list")
  end
  
  it "Should set frame" do
    todo = Todo.create!(:title => "title")
    post todos_set_frame_path, {:id => todo.id, :frame => "family" }
    visit todos_path
    #todo should be placed under family category
    find('#family').should have_content("#{todo.title}")
    #page.should have_content("#{todo.title}")    
  end
  
  it "Should rename todo" do
    todo = Todo.create!(:title => "title")
    post todos_rename_path, {:id => todo.id, :title => "new title"}
    visit todos_path
    page.should have_content("new title")
  end
  
  it "Should remove todo" do
    todo = Todo.create!(:title => "title")
    delete "#{todos_path}/#{todo.id}"
    visit todos_path
    page.should_not have_content("#{todo.title}")
  end
  
  it "Should set sorting" do
    t1 = Todo.create!(:title => "title 1", :frame_order_number => 1)
    t2 = Todo.create!(:title => "title 2", :frame_order_number => 2)
    t3 = Todo.create!(:title => "title 3", :frame_order_number => 3)
    
    post todos_set_sorting_path, {:sorted_todos => [t3.id, t2.id, t1.id]}
    
    Todo.find(t1.id).frame_order_number == 3
    Todo.find(t2.id).frame_order_number == 2
    Todo.find(t3.id).frame_order_number == 1
  end
  
end
