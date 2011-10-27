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
  
  # list of devise options
  # https://github.com/plataformatec/devise
  devise :omniauthable,
         :database_authenticatable, 
         #:registerable,
         #:recoverable, 
         :rememberable, 
         :trackable, 
         :validatable

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
  
  def past_todos
    past_todos = Array.new
    todos.each do |todo|
      if todo.due_date <= Date.yesterday
        past_todos << todo
      end
    end
    past_todos
  end
  
  def current_todos  
    current_todos = Array.new
    yesterday = Date.yesterday
    future = Date.today >> 11
    todos.each do |todo|
      if todo.due_date > yesterday && todo.due_date < future
        current_todos << todo
      end
    end
    current_todos
  end
  
  def future_todos
    future_todos = Array.new
    future = Date.today >> 11
    todos.each do |todo|
      if todo.due_date >= future
        future_todos << todo
      end
    end
    future_todos
  end
  
  def done_todos_percentage
    count = todos.count
    result = 0
    if (count > 0)
      done_count = todos.where(:status => "done").count
      result = (done_count * 100 / count) 
    end
    result
  end
  
end