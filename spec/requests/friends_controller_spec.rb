require 'spec_helper'

describe FriendsController do
  include LoginMacros
  let(:user) { User.create!(:id => "1", :email => "e@e.com", :password => "password") }
  
  it "should display loged in facebook users facebook friends using The Bucket List", :js => true do
    friend = Factory(:user)
    FacebookDude.stub!(:friends).and_return([friend])
    
    login_facebook user
    
    visit friends_path
    page.should have_content(friend.id)

  end

  # you can use this spec if you want to authenticat through devise views
  # it "should be able to register new user", :js => true do
  #   user = User.create!(:id => "1637261457", :token => "token", :email => "ali@example.com", :password => "alipassword")
  #   
  #   visit new_user_session_path
  #   fill_in "user_email", :with => user.email
  #   fill_in "user_password", :with => "alipassword"
  #   click_button "Sign in"
  #   
  #   visit new_user_session_path
  #   page.should have_content("You are already signed in.")
  # 
  #   visit friends_path
  # end
end
