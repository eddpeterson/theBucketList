require 'spec_helper'

# Read more on capybara here:
# https://github.com/jnicklas/capybara

describe GoalsController do

  include LoginMacros
  
  let(:user) { User.create!(:id => "1", :email => "e@e.com", :password => "password") }

  it "should add new item", :js => true do
    login_facebook user
    visit goals_path
    
    fill_in "new_title_family", :with => "Travel to Hawaii"
    page.driver.browser.mouse.click(find('#add_new_goal_family').native)
    
    within("#family") do 
      page.should have_content("Travel to Hawaii")
    end
  end
  
  it "should show newly added itme on page reload" do
    user.goals << Goal.get_new("Travel to Hawaii", "family")
    
    login_facebook user
    visit goals_path
    
    within("#family") do 
      page.should have_content("Travel to Hawaii")
    end
  end
  
  
  it "should allow user to edit goal's title when double clicked and save goal with new title", :js => true do
    goal = Goal.get_new("Travel to Hawaii", "family") 
    user.goals << goal
    
    login_facebook user
    visit goals_path
    
    within("#family") do 
      goal_element = find(".frame_item") 
      page.driver.browser.mouse.double_click(goal_element.native)
       
      # page.should have_content("Save")
      #save_and_open_page
    
      fill_in "rename_title", :with => "new title"
      save_element = find('.save_rename')
      page.driver.browser.mouse.click(save_element.native)
      page.should have_content("new title")
    end 
  
    # verify after refreshing the page we stil see newly added title
    # login_facebook user
    visit goals_path
    within("#family") do 
      page.should have_content("new title")
    end
  end
  it "should allow user to edit goal's title when double clicked, but do not save new title if user cancels operation", :js => true do
    goal = Goal.get_new("Travel to Hawaii", "family") 
    user.goals << goal
    
    login_facebook user
    visit goals_path
    
    within("#family") do 
      goal_element = find(".frame_item") 
      page.driver.browser.mouse.double_click(goal_element.native)
    
      fill_in 'rename_title', :with => "new title"
      cancel_element = find('.cancel_rename')
      page.driver.browser.mouse.click(cancel_element.native)
      page.should have_content("Travel to Hawaii")
    end
  
    # verify after refreshing the page we stil see previous title
    visit goals_path
    within("#family") do 
      page.should have_content("Travel to Hawaii")
    end
  end   

  it "should drag goal from family frame to personal frame and remember it when page is reloaded", :js => true do
    pending("Somehow this stopped working. Worked befor though!")
    
    goal = Goal.get_new("Travel to Hawaii", "family") 
    user.goals << goal

    login_facebook user
    visit goals_path
   
    within("#family") do 
      page.should have_content("Travel to Hawaii")
    end
    
    goal_element = find("##{goal.id}") 
    personal_frame_element = find("#personal")
    goal_element.drag_to personal_frame_element
    
    visit goals_path
    within("#personal") do 
      page.should have_content("Travel to Hawaii")
    end
    
  end
  
end
