require 'spec_helper'

# Read more on capybara here:
# https://github.com/jnicklas/capybara

describe FriendsController do
  #include Devise::TestHelpers
  #include DeviseSessionMock
  
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
  
  # 
  # before do
  #   OmniAuth.config.test_mode = true
  #   OmniAuth.config.mock_auth[:facebook] = {
  #     "provider"=>"facebook", 
  #     "credentials"=>{ "token"=>"AAAB0mTOQNCwBAKTWXk01tMBAkDWOERp9z7sKkYrJLnsfXBa5mSQzIZAYrPYiImM0Ff4ZAXGWDKknnp2sgBEtc6dfOfITgZD"}, 
  #     "extra"=>{ "user_hash"=>{"id"=>"1637261457", "email"=>"eddpeterson@gmail.com", "name"=>"Edijs Petersons", "first_name"=>"Edijs", "last_name"=>"Petersons" }}
  #   }
  #   # request.env["devise.mapping"] = Devise.mappings[:user] 
  #   #     request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  #   visit root_path
  #   click_link 'Login'
  # end
  # before (:each) do
  #     #before(:each) do
  #       #puts request.methods.sort
  #       #request.env["devise.mapping"] = Devise.mappings[:user]
  #       user = User.create!(:id => "123", :token => "token")#Factory.create(:user)
  #       #user.confirm!
  #       user.save
  #       sign_in user 
  #     #end
  #   end

  # before (:each) do
  #     #before(:each) do
  #       #puts request.methods.sort
  #       #request.env["devise.mapping"] = Devise.mappings[:user]
  #       user = User.create!(:id => "1637261457", :token => "token", :email => "a@example.com", :password => "password")#Factory.create(:user)
  #       #user.confirm!
  #       user.save
  #       sign_in user 
  #     #end
  #   end


  it "bla bla bla", :js => true do
    FacebookDude.stub!(:friends).and_return([User.create({"_id" => "100000068985859"})])
    
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = {
      "provider"=>"facebook", 
      "credentials"=>{ "token"=>"AAAB0mTOQNCwBAKTWXk01tMBAkDWOERp9z7sKkYrJLnsfXBa5mSQzIZAYrPYiImM0Ff4ZAXGWDKknnp2sgBEtc6dfOfITgZD"}, 
      "extra"=>{ "user_hash"=>{"id"=>"1637261457", "email"=>"eddpeterson@gmail.com", "name"=>"Edijs Petersons", "first_name"=>"Edijs", "last_name"=>"Petersons" }}
    }
  
    visit new_user_session_path
    click_link "Sign in with Facebook"
    page.should have_content("Successfully authorized from Facebook account.")

    visit friends_path
    page.should have_content("100000068985859")

  end

  it "should be able to register new user", :js => true do
    # visit new_user_registration_path
    # fill_in "user_email", :with => "ali@gmail.com"
    # fill_in "user_password", :with => "alipassword"
    # fill_in "user_password_confirmation", :with => "alipassword"
    # click_button "Sign up"
    
    user = User.create!(:id => "1637261457", :token => "token", :email => "ali@example.com", :password => "alipassword")
    #:encrypted_password => "$2a$10$Mm2B3h1BmKBirajLYHzlI.TufM5lDstFKRXhQy7u2HvfSIWJuuK06")#Factory.create(:user)

    visit new_user_session_path
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => "alipassword"
    click_button "Sign in"
    
    #visit new_user_registration_path
    visit new_user_session_path
    page.should have_content("You are already signed in.")

    visit friends_path
    #save_and_open_page
    # user = User.create!(:id => "1637261457", :token => "token", :email => "user@example.com", :password => "password")#Factory.create(:user)
    #     #user.confirm!
    #     user.save
    #     visit new_user_session_path
    #     fill_in "user_email",    :with => "user@example.com"
    #     fill_in "user_password", :with => "password"
    #     click_button "Sign in"
    #     # subject.current_user.should_not be_nil
    #     #     puts "id...................."
    #     #     puts subject.current_user.id
    #     #     
         #visit friends_path
    #save_and_open_page
    #page.should have_content("js works")
  end
  
  # it "should have a current_user" do
  #     
  #     rack_test_session_wrapper = Capybara.current_session.driver
  #     rack_test_session_wrapper.process :post, fake_log_in_path, {:id => "123", :email => "123@example.com", :token => "token123"}
  #     
  #     rack_test_session_wrapper.process :get, friends_path #[capybara](http://github.com/jnicklas/capybara) wrapper which will pass along the current rack env
  #     
  #     #save_and_open_page
  #     #subject.current_user.should_not be_nil
  #   end
  
  # it "wadaaa", :js => true do
  #   
  #   
  #   #post fake_log_in_path, {:id => "123", :email => "123@example.com", :token => "token123"}
  #   #DeviseSessionMock.enable(Factory :user)
  #   #user = User.create!(:id => "123", :email => "123@example.com")
  #   #user = nil
  #   #FriendsController.stub!(:current_user).and_return(user)
  #   #sign_in User.create!(:id => "123")
  #   
  #   
  #   # OmniAuth.config.test_mode = true
  #   #     OmniAuth.config.mock_auth[:facebook] = {
  #   #       "provider"=>"facebook", 
  #   #       "credentials"=>{ "token"=>"AAAB0mTOQNCwBAKTWXk01tMBAkDWOERp9z7sKkYrJLnsfXBa5mSQzIZAYrPYiImM0Ff4ZAXGWDKknnp2sgBEtc6dfOfITgZD"}, 
  #   #       "extra"=>{ "user_hash"=>{"id"=>"1637261457", "email"=>"eddpeterson@gmail.com", "name"=>"Edijs Petersons", "first_name"=>"Edijs", "last_name"=>"Petersons" }}
  #   #     }
  #   #     # request.env["devise.mapping"] = Devise.mappings[:user] 
  #   #     #     request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  #   #     visit root_path
  #   #     click_link 'Login'
  #   
  #   visit friends_path
  #   save_and_open_page
  #   
  #   
  #   #rack_test_session_wrapper.process :delete, admin_session_path #[capybara](http://github.com/jnicklas/capybara) wrapper which will pass along the current rack env
  #   
  # end
end
