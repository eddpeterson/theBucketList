require 'spec_helper'

# Read more on capybara here:
# https://github.com/jnicklas/capybara

describe FriendsController do
  #include Devise::TestHelpers
  
  
  # READ!!!!:
  #   
  #   https://github.com/plataformatec/devise/wiki/How-To%3a-Controllers-and-Views-tests-with-Rails-3-%28and-rspec%29
  #   
  #   
  #   
  # 
  
  # before(:each) do
  #   @user = User.create(:id => "123", :token => "token")
  #   #sign_in @user
  #   
  #   #request.env["devise.mapping"] = Devise.mappings[:user]
  #   #user = Factory.create(:user)
  #   #user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
  #   sign_in @user
  # end
  
  
  # it "should display facebook friends that are using bucket list" do
  #    @user = User.create(:id => "123", :token => "token")
  #   #     #sign_in @user
  #   #     
  #   #     #request.env["devise.mapping"] = Devise.mappings[:user]
  #   #     #user = Factory.create(:user)
  #   #     #user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
  #   #     sign_in @user
  #   
  #   #FriendsController.stub!(:current_user).and_return(@user)
  #   
  #   visit friends_path
  #    
  #   page.should have_content("Q")
  # end
  
end
