class FriendsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html  
  
  def index
    #facebook_access_token = session["devise.facebook_data"]
    #id = facebook_access_token['extra']['user_hash']['id']
    #token = facebook_access_token['credentials']['token']
    
    # id = current_user.id
    #     token = current_user.token
    #     friends = Friend.find_my_facebook_friends(id, token)
    #     puts User.any_in("_id" => friends)
    #puts friends
    
    @friends = current_user.friends
    
  end
  
  

  
end