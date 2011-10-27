module LoginMacros
  def login_facebook user
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = {
      "provider"=>"facebook", 
      "credentials"=>{ "token"=>"AAAB0mTOQNCwBAKTWXk01tMBAkDWOERp9z7sKkYrJLnsfXBa5mSQzIZAYrPYiImM0Ff4ZAXGWDKknnp2sgBEtc6dfOfITgZD"}, 
      "extra"=>{ "user_hash"=>{"id"=>"#{user.id}", "email"=>"eddpeterson@gmail.com", "name"=>"Edijs Petersons", "first_name"=>"Edijs", "last_name"=>"Petersons" }}
    }
    visit root_path
    click_link "Login"
    # Now I am doing hacking. By some reason tests using login_facebook fails time after time. 
    # My guess is that we jump to the next page before we actually have authorized so I force waiting manually
    sleep 0.1 
  end
  # def login_user
  #     before(:each) do
  #       #friend = Factory(:user)
  #       #FacebookDude.stub!(:friends).and_return([friend])
  # 
  #       OmniAuth.config.test_mode = true
  #       OmniAuth.config.mock_auth[:facebook] = {
  #         "provider"=>"facebook", 
  #         "credentials"=>{ "token"=>"AAAB0mTOQNCwBAKTWXk01tMBAkDWOERp9z7sKkYrJLnsfXBa5mSQzIZAYrPYiImM0Ff4ZAXGWDKknnp2sgBEtc6dfOfITgZD"}, 
  #         "extra"=>{ "user_hash"=>{"id"=>"1", "email"=>"eddpeterson@gmail.com", "name"=>"Edijs Petersons", "first_name"=>"Edijs", "last_name"=>"Petersons" }}
  #       }
  # 
  #       visit root_path
  #       click_link "Login"
  #       
  #       # This does not work as described here:
  #       # https://github.com/plataformatec/devise/wiki/How-To%3a-Controllers-and-Views-tests-with-Rails-3-%28and-rspec%29
  #       #@request.env["devise.mapping"] = Devise.mappings[:user]
  #       #sign_in Factory(:user) # Using factory girl as an example
  #       
  #     end
  #   end
end