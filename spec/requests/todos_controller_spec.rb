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
  
  
  
  it "Should remove todo" do
    todo = Todo.create!(:title => "title")
    delete "#{todos_path}/#{todo.id}"
    visit todos_path
    page.should_not have_content("#{todo.title}")
  end
  
  it "should set sorting and frame" do
    t1 = Todo.create!(:title => "title 1", :frame_order_number => 1, :frame => "work")
    t2 = Todo.create!(:title => "title 2", :frame_order_number => 2, :frame => "personal")
    t3 = Todo.create!(:title => "title 3", :frame_order_number => 3, :frame => "social")
    
    post todos_set_sorting_path, {:sorted_todos => [t3.id, t2.id, t1.id], :frame => "family"}
    
    Todo.find(t1.id).frame_order_number == 3
    Todo.find(t2.id).frame_order_number == 2
    Todo.find(t3.id).frame_order_number == 1
    Todo.find(t1.id).frame == "family"
    Todo.find(t2.id).frame == "family"
    Todo.find(t3.id).frame == "family"
  end
  
  it "should ignore set sorting for empty array" do
    post todos_set_sorting_path, {:sorted_todos => [], :frame => "family"}
  end
  
  
  # it "Should rename todo" do
  #   todo = Todo.create!(:title => "title")
  #   post todos_rename_path, {:id => todo.id, :title => "new title"}
  #   visit todos_path
  #   page.should have_content("new title")
  # end
  it "should allow user to edit todo's title when double clicked and save todo with new title", :js => true do
    todo = Todo.create!(:title => "my todo")
    visit todos_path
    
    todo_element = find(".frame_item") 
    page.driver.browser.mouse.double_click(todo_element.native)
    
    # page.should have_content("Save")
    #save_and_open_page
    
    fill_in "rename_title", :with => "new title"
    save_element = find('.save_rename')
    page.driver.browser.mouse.click(save_element.native)
    page.should have_content("new title")
    # verify after refreshing the page we stil see newly added title
    visit todos_path
    page.should have_content("new title")
  end
  it "should allow user to edit todo's title when double clicked, but do not save new title if user cancels operation", :js => true do
    todo = Todo.create!(:title => "my todo")
    visit todos_path
    
    todo_element = find(".frame_item") 
    page.driver.browser.mouse.double_click(todo_element.native)
    
    fill_in 'rename_title', :with => "new title"
    cancel_element = find('.cancel_rename')
    page.driver.browser.mouse.click(cancel_element.native)
    page.should have_content("my todo")
    # verify after refreshing the page we stil see previous title
    visit todos_path
    page.should have_content("my todo")
  end
    

  it "should drag todo from family frame to personal frame and remember it when page is reloaded", :js => true do
    todo = Todo.create!(:title => "title 1", :frame => "family")
    
    visit todos_path
    within("#family") do 
      page.should have_content("title 1")
    end
    
    todo_element = find("##{todo.id}") 
    personal_frame_element = find("#personal")
    todo_element.drag_to personal_frame_element
    
    visit todos_path
    within("#personal") do 
      page.should have_content("title 1")
    end
    
  end
  
  it "should drag todo to from family frame to none frame and set frame to nil", :js => true do
    todo = Todo.create!(:title => "title 1", :frame => "family")
    
    visit todos_path
    within("#family") do 
      page.should have_content("title 1")
    end
    
    todo_element = find("##{todo.id}") 
    none_frame_element = find("#none")
    todo_element.drag_to none_frame_element
    
    visit todos_path
    within("#none") do 
      page.should have_content("title 1")
    end
    
  end
 
end
