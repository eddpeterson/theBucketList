require 'spec_helper'

describe FriendsController do
  it "should display loged in facebook users facebook friends using The Bucket List", :js => true do
    friend = Factory(:user)
    FacebookDude.stub!(:friends).and_return([friend])
    
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = {
      "provider"=>"facebook", 
      "credentials"=>{ "token"=>"AAAB0mTOQNCwBAKTWXk01tMBAkDWOERp9z7sKkYrJLnsfXBa5mSQzIZAYrPYiImM0Ff4ZAXGWDKknnp2sgBEtc6dfOfITgZD"}, 
      "extra"=>{ "user_hash"=>{"id"=>"1", "email"=>"eddpeterson@gmail.com", "name"=>"Edijs Petersons", "first_name"=>"Edijs", "last_name"=>"Petersons" }}
    }
  
    visit root_path
    click_link "Login"
    page.should have_content("Successfully authorized from Facebook account.")

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
