class User
  include Mongoid::Document  
  field :email, type: String
  identity :type => String # overriding id field to be String type
  #key :email
  devise :omniauthable
  
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    #puts data
    id = data['id']
    email = data['email']
    
    if User.exists?(conditions: { id: id })
      user = User.find(id)
      #user = User.where(email: data["email"]).first
    else # Create a user with a stub password. 
      User.create(:id => id, :email => email) 
    end
  end
  
end