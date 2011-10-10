class User
  include Mongoid::Document  
  field :email, type: String
  field :password, type: String
  
  devise :omniauthable
  
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if User.exists?(conditions: { email: data["email"] })
      user = User.where(email: data["email"]).first
    else # Create a user with a stub password. 
      User.create(:email => data["email"], :password => Devise.friendly_token[0,20]) 
    end
  end
  
end