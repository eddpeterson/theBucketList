require 'spec_helper'

# Read more on capybara here:
# https://github.com/jnicklas/capybara

describe TimelinesController do  
  
  include LoginMacros
  
  let(:user) { User.create!(:id => "1", :email => "e@e.com", :password => "password") }
  
  context "Timeline boxes" do
    before do 
        @todo_yesterday = Todo.get_new("Travel to Furteventura", "family")
        @todo_yesterday.due_date = Date.yesterday
        user.todos << @todo_yesterday
        @todo_today = Todo.get_new("Travel to Gran Canaria in winter", "family")
        @todo_today.due_date = Date.today
        user.todos << @todo_today
        @todo_today_last = Todo.get_new("Travel to Gran Canaria in summber", "family")
        @todo_today_last.due_date = Date.today >> 10
        user.todos << @todo_today_last
        @todo_future = Todo.get_new("Travel to Hawaii", "family")
        @todo_future.due_date = Date.today >> 11
        user.todos << @todo_future
        
        login_facebook user
        visit timeline_path
    end
    
    it "should place todos with yesterdays due date in past box" do
      within("#past_box") do 
        page.should have_content("#{@todo_yesterday.title}")
        page.should_not have_content("#{@todo_today.title}")
        page.should_not have_content("#{@todo_today_last.title}")
        page.should_not have_content("#{@todo_future.title}")   
      end
    end
    
    it "should place todos with current due date that is not greater than 10 months in current box" do
      within("#current_box") do 
        page.should have_content("#{@todo_today.title}")
        page.should have_content("#{@todo_today_last.title}")      
        page.should_not have_content("#{@todo_yesterday.title}")
        page.should_not have_content("#{@todo_future.title}")
      end
    end
  
    it "should place todos with more than 10months due date in 10+ box" do
      within("#future_box") do 
        page.should have_content("#{@todo_future.title}")
        page.should_not have_content("#{@todo_yesterday.title}")
        page.should_not have_content("#{@todo_today.title}")
        page.should_not have_content("#{@todo_today_last.title}")
      end    
    end
  end
  
  it "should display done status" do
    todo_done = Todo.get_new("Travel to Fuerteventura", "family")
    todo_done.status = "done"
    user.todos << todo_done

    login_facebook user
    visit timeline_path
    
    element = find(".status")
    element.value.should == "done"
  end
  
  it "should display undone status" do
    todo_done = Todo.get_new("Travel to Gran Canaria", "family")
    todo_done.status = nil
    user.todos << todo_done

    login_facebook user
    visit timeline_path
    
    element = find(".status")
    element.value.should be_empty    
  end
  
  it "should change undone to done status", :js => true do
    todo_done = Todo.get_new("Travel to Gran Canaria", "family")
    todo_done.status = nil
    user.todos << todo_done
    
    login_facebook user
    visit timeline_path

    element = find(".status")
    page.driver.browser.mouse.click(element.native)
    
    #verify value is changed on click
    element.value.should == "done"
    
    # verify value is the same on refresh
    visit timeline_path
    element = find(".status") 
    element.value.should == "done"    
  end
  
  
  it "should display completed todos percentage", :js => true do   
    # create one done and one undone task
    user.todos << Todo.get_new("Travel to Hawaii", "family")
    todo_done = Todo.get_new("Travel to Fuerteventura", "family")
    todo_done.status = "done"
    user.todos << todo_done
    
    login_facebook user
    visit root_path
    
    page.should have_content("50% goals completeness")
  end
  
end
