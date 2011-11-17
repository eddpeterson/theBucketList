class User
  include Mongoid::Document  
  field :email, type: String
  field :token, type: String
  field :name, type: String
  field :first_name, type: String
  field :last_name, type: String
  
  identity :type => String # overriding id field to be String type
  #key :email
  
  embeds_many :goals
  
  # list of devise options
  # https://github.com/plataformatec/devise
  devise :omniauthable,
         #:database_authenticatable, 
         #:registerable,
         #:recoverable, 
         :rememberable, 
         :trackable 
         #:validatable

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    
    data = access_token['extra']['user_hash']
    id = data['id']
    token = access_token['credentials']['token']
    
    if User.exists?(conditions: { id: id })
      user = User.find(id)
      #user = User.where(email: data["email"]).first
    else # Create a user with a stub password. 
      user = User.create(:id => id, :email => data['email'], :name => data['name'], :first_name => data['first_name'], :last_name => data['last_name']) 
    end
    # update token that is used at the moment because I do not know a better way. Need to look into that when trying FBGraph or other facebook lib
    user.token = token
    user.save
    user
  end
  
  def past_goals
    past_goals = Array.new
    goals.each do |goal|
      if goal.past?
        past_goals << goal
      end
    end
    sort_descending past_goals
  end
  
  def current_goals  
    current_goals = Array.new
    goals.each do |goal|
      if goal.current?
        current_goals << goal
      end
    end
    sort current_goals
  end
  
  def future_goals
    future_goals = Array.new
    goals.each do |goal|
      if goal.future?
        future_goals << goal
      end
    end
    sort future_goals
  end
  
  def done_goals_percentage
    count = goals.count
    result = 0
    if (count > 0)
      done_count = goals.where(:status => "done").count
      result = (done_count * 100 / count) 
    end
    result
  end
  
  def sort goals
    unless goals.nil?
      goals.sort {|a,b| a.due_date <=> b.due_date}
    end
  end
  
  def sort_descending goals
    unless goals.nil?
      goals.sort {|a,b| b.due_date <=> a.due_date}
    end
  end
  
end