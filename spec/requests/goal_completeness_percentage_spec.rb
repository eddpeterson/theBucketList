require 'spec_helper'

describe "Goals Completeness Percentage" do  

  include LoginMacros

  let(:user) { User.create!(:id => "1", :email => "e@e.com", :password => "password") }


  it "should display 0% goal percentage for users with no goals", :js => true do
    login_facebook user
    visit root_path

    page.should have_content("0% goals completeness")
  end
  it "should display goals completeness percentage", :js => true do
    goal_done = Goal.get_new("Travel to Fuerteventura", "family")
    goal_done.status = "done"
    user.add_goal(goal_done)

    login_facebook user
    visit root_path

    page.should have_content("100% goals completeness")
  end
  describe "should update completed goals satatus" do

    it "when adding new goal", :js => true do
      goal_done = Goal.get_new("Travel to Fuerteventura", "family")
      goal_done.status = "done"
      user.add_goal(goal_done)

      login_facebook user
      visit goals_path

      fill_in "new_title_family", :with => "Travel to Hawaii"
      page.driver.browser.mouse.click(find('#add_new_goal_family').native)
      
      # verify that after adding new goal and setting it status to done goal completeness percentage is updated
      page.should have_content("50% goals completeness")
    end

    it "when removing new goal", :js => true do
      goal_done = Goal.get_new("Travel to Fuerteventura", "family")
      goal_done.status = "done"
      user.add_goal(goal_done)

      login_facebook user
      visit goals_path
      
      # move mouse over the item to make trach icon visible
      puts page.driver.browser.mouse.up(find('.frame_item_readonly').native)
      
      trash_icon = find('.remove_goal')
      page.driver.browser.mouse.click(trash_icon.native)
      click_button "Delete"
      
      # verify that after adding new goal and setting it status to done goal completeness percentage is updated
      page.should have_content("0% goals completeness")
    end 

    it "when goal status is changed", :js => true do   
      user.goals << Goal.get_new("Travel to Hawaii", "family")

      login_facebook user
      visit timeline_path

      # update goal status to done
      element = find(".status")
      page.driver.browser.mouse.click(element.native)

      page.should have_content("100% goals completeness")
    end
  end

end