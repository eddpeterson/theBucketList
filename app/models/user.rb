class User
  include Mongoid::Document  
  field :email, type: String
  field :token, type: String
  field :name, type: String
  field :first_name, type: String
  field :last_name, type: String
  
  identity :type => String # overriding id field to be String type
  #key :email
  
  embeds_many :todos
  
  devise :omniauthable,
         :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    
    data = access_token['extra']['user_hash']
    id = data['id']
    token = access_token['credentials']['token']
    
    if User.exists?(conditions: { id: id })
      user = User.find(id)
      #user = User.where(email: data["email"]).first
    else # Create a user with a stub password. 
      user = User.create(:id => id, :email => data['email'], :password => "password", :name => data['name'], :first_name => data['first_name'], :last_name => data['last_name']) 
    end
    # update token that is used at the moment because I do not know a better way. Need to look into that when trying FBGraph or other facebook lib
    user.token = token
    user.save
    user
  end
  
  
  
end