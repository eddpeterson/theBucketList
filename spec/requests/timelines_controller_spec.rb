require 'spec_helper'

# Read more on capybara here:
# https://github.com/jnicklas/capybara

describe TimelinesController do  
  
  include LoginMacros
  
  let(:user) { User.create!(:id => "1", :email => "e@e.com", :password => "password") }
  
  context "Timeline boxes" do
    before do 
        @goal_yesterday = Goal.get_new("Travel to Furteventura", "family")
        @goal_yesterday.due_date = Date.yesterday
        user.goals << @goal_yesterday
        @goal_today = Goal.get_new("Travel to Gran Canaria in winter", "family")
        @goal_today.due_date = Date.today
        user.goals << @goal_today
        @goal_today_last = Goal.get_new("Travel to Gran Canaria in summber", "family")
        @goal_today_last.due_date = Date.today >> 10
        user.goals << @goal_today_last
        @goal_future = Goal.get_new("Travel to Hawaii", "family")
        @goal_future.due_date = Date.today >> 11
        user.goals << @goal_future
        
        login_facebook user
        visit timeline_path
    end
    
    it "should place goals with yesterdays due date in past box" do
      within("#past_box") do 
        page.should have_content("#{@goal_yesterday.title}")
        page.should_not have_content("#{@goal_today.title}")
        page.should_not have_content("#{@goal_today_last.title}")
        page.should_not have_content("#{@goal_future.title}")   
      end
    end
    
    it "should place goals with current due date that is not greater than 10 months in current box" do
      within("#current_box") do 
        page.should have_content("#{@goal_today.title}")
        page.should have_content("#{@goal_today_last.title}")      
        page.should_not have_content("#{@goal_yesterday.title}")
        page.should_not have_content("#{@goal_future.title}")
      end
    end
  
    it "should place goals with more than 10months due date in 10+ box" do
      within("#future_box") do 
        page.should have_content("#{@goal_future.title}")
        page.should_not have_content("#{@goal_yesterday.title}")
        page.should_not have_content("#{@goal_today.title}")
        page.should_not have_content("#{@goal_today_last.title}")
      end    
    end
  end
  
  it "should display done status" do
    goal_done = Goal.get_new("Travel to Fuerteventura", "family")
    goal_done.status = "done"
    user.goals << goal_done

    login_facebook user
    visit timeline_path
    
    element = find(".status")
    element.value.should == "done"
  end
  
  it "should display undone status" do
    goal_done = Goal.get_new("Travel to Gran Canaria", "family")
    goal_done.status = nil
    user.goals << goal_done

    login_facebook user
    visit timeline_path
    
    element = find(".status")
    element.value.should be_empty    
  end
  
  it "should change undone to done status", :js => true do
    goal_done = Goal.get_new("Travel to Gran Canaria", "family")
    goal_done.status = nil
    user.goals << goal_done
    
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
  
  
  it "should display completed goals percentage", :js => true do   
    # create one done and one undone task
    user.goals << Goal.get_new("Travel to Hawaii", "family")
    goal_done = Goal.get_new("Travel to Fuerteventura", "family")
    goal_done.status = "done"
    user.goals << goal_done
    
    login_facebook user
    visit root_path
    
    page.should have_content("50% goals completeness")
  end
  
end
