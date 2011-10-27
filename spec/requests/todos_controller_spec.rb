require 'spec_helper'

# Read more on capybara here:
# https://github.com/jnicklas/capybara

describe TodosController do

  include LoginMacros
  
  let(:user) { User.create!(:id => "1", :email => "e@e.com", :password => "password") }

  it "should add new item", :js => true do
    login_facebook user
    visit todos_path
    
    within("#family") do 
      fill_in "new_title", :with => "Travel to Hawaii"
      click_button "Add"
      page.should have_content("Travel to Hawaii")
    end
  end
  
  it "should show newly added itme on page reload" do
    user.todos << Todo.get_new("Travel to Hawaii", "family")
    
    login_facebook user
    visit todos_path
    
    within("#family") do 
      page.should have_content("Travel to Hawaii")
    end
  end


  it "should allow user to edit todo's title when double clicked and save todo with new title", :js => true do
    todo = Todo.get_new("Travel to Hawaii", "family") 
    user.todos << todo
    
    login_facebook user
    visit todos_path
    
    within("#family") do 
      todo_element = find(".frame_item") 
      page.driver.browser.mouse.double_click(todo_element.native)
       
      # page.should have_content("Save")
      #save_and_open_page
    
      fill_in "rename_title", :with => "new title"
      save_element = find('.save_rename')
      page.driver.browser.mouse.click(save_element.native)
      page.should have_content("new title")
    end 

    # verify after refreshing the page we stil see newly added title
    # login_facebook user
    visit todos_path
    within("#family") do 
      page.should have_content("new title")
    end
  end
  it "should allow user to edit todo's title when double clicked, but do not save new title if user cancels operation", :js => true do
    todo = Todo.get_new("Travel to Hawaii", "family") 
    user.todos << todo
    
    login_facebook user
    visit todos_path
    
    within("#family") do 
      todo_element = find(".frame_item") 
      page.driver.browser.mouse.double_click(todo_element.native)
    
      fill_in 'rename_title', :with => "new title"
      cancel_element = find('.cancel_rename')
      page.driver.browser.mouse.click(cancel_element.native)
      page.should have_content("Travel to Hawaii")
    end

    # verify after refreshing the page we stil see previous title
    visit todos_path
    within("#family") do 
      page.should have_content("Travel to Hawaii")
    end
  end
    

  it "should drag todo from family frame to personal frame and remember it when page is reloaded", :js => true do
    todo = Todo.get_new("Travel to Hawaii", "family") 
    user.todos << todo

    login_facebook user
    visit todos_path
   
    visit todos_path
    within("#family") do 
      page.should have_content("Travel to Hawaii")
    end
    
    todo_element = find("##{todo.id}") 
    personal_frame_element = find("#personal")
    todo_element.drag_to personal_frame_element
    
    visit todos_path
    within("#personal") do 
      page.should have_content("Travel to Hawaii")
    end
    
  end
  
end
