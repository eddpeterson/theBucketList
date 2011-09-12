require 'spec_helper'

describe "TodosControllers" do
  # describe "GET /todo_controllers" do
  #     it "works! (now write some real specs)" do
  #       # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
  #       get todos_controllers_path
  #       response.status.should be(200)
  #     end
  #   end
  it "Add new item" do
    todo = Factory(:todo)
    visit new_todo_path
    fill_in "Title", :with => todo.title
    fill_in "Due date", :with => todo.due_date
    click_button "Add"
    current_path.should eq(todos_path)
    page.should have_content("#{todo.title} added to your bucket list")
  end
  
  
  # Feature: Bucket list 
  #   In order to add new items to bucket list
  #   As a website visitor
  #   I want to be able to fill in title and due date of a new item
  # 
  #   Scenario: Add new todo
  #     Given I am on the home page
  #     When I fill in "todo_title" with "Travel to Thaiti"
  #     And I fill in "todo_due_date" with "1/1/2020"
  #     And I press "Add"
  #     Then I should see "Travel to Thaiti added to your bucket list"
  
end
