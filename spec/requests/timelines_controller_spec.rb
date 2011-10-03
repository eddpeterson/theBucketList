require 'spec_helper'

# Read more on capybara here:
# https://github.com/jnicklas/capybara

describe "TimelinesController" do  
  
  before do 
      @todo_yesterday = Todo.create!(:title => "title1", :frame => "family", :due_date => Date.yesterday)
      @todo_today = Todo.create!(:title => "title2", :frame => "family", :due_date => Date.today)
      @todo_today_last = Todo.create!(:title => "title3", :frame => "family", :due_date => Date.today >> 10)
      @todo_future = Todo.create!(:title => "title4", :frame => "family", :due_date => Date.today >> 11)
      
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
