class User
  include Mongoid::Document
  include FacebookInfo  
  field :email, type: String
  field :token, type: String
  field :name, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :completed_goals_percentage, type: Integer, default: 0
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
         
  def self.find_or_create(id, access_token)
    if User.exists?(conditions: { id: id })
      user = User.find(id)
      user.token = access_token
      user.save
    else
      user = User.create(id: id, token: access_token)
      user.update_facebook_info
    end
    
    user
  end
  
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
  
  def update_facebook_info
    info = facebook_info(self.id, self.token)
    self.email = info['email']
    self.name = info['name']
    self.first_name = info['first_name']
    self.last_name = info['last_name']
    save
  end
  
  def friends
    facebook_friends = friends_ids(self.id, self.token)
    friends = User.any_in("_id" => facebook_friends)
    friends
  end
  
  def set_goal_status(goal_id, new_status)
    goal = goals.find(goal_id)
    goal.status = new_status
    goal.save
    update_completed_goals_percentage
  end
  
  def add_goal(goal)
    goals << goal
    update_completed_goals_percentage
    set_goal_on_top(goal) 
  end
  
  def set_goal_on_top(goal)
    framed_goals = goals.where(frame: goal.frame).order_by([:frame_order_number, :asc])
    unless framed_goals.nil?
      order_number = 2
      goal.frame_order_number = 1
      goal.save
      framed_goals.each do |framed_goal|
        unless framed_goal == goal
          framed_goal.frame_order_number = order_number
          order_number += 1
          framed_goal.save
        end
      end
    end
  end
  
  def remove_goal(goal_id)
    goal = goals.find(goal_id)
    goal.delete
    update_completed_goals_percentage
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
  
  def update_completed_goals_percentage
    self.completed_goals_percentage = calculate_goals_percentage
    save
  end
  def calculate_goals_percentage
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
  
  def append_to_goal_id goal
    id = nil
    if goal.past?
      past_goals.each do |past_goal|
        break if goal.due_date > past_goal.due_date || goal == past_goal
        id = past_goal.id
      end
    elsif goal.current?
      current_goals.each do |current_goal|
        break if goal.due_date < current_goal.due_date || goal == current_goal
        id = current_goal.id
      end    
    else goal.future?
      future_goals.each do |future_goal|
        break if goal.due_date < future_goal.due_date || goal == future_goal
        id = future_goal.id
      end
    end
    
    id
  end
  
end