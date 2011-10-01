class Todo
  include Mongoid::Document  
  field :title, type: String
  field :due_date, type: Date, default: Date.today
  field :frame, type: String
  field :frame_order_number, type: Integer
  
  validates_presence_of :title
  
  #scope :past_todos, where(:due_date < Date.yesterday)
  def self.past_todos
    past_todos = Array.new
    Todo.all.each do |todo|
      if todo.due_date <= Date.yesterday
        past_todos << todo
      end
    end
    past_todos
  end
  
  def self.current_todos  
    current_todos = Array.new
    yesterday = Date.yesterday
    future = Date.today >> 11
    Todo.all.each do |todo|
      if todo.due_date > yesterday && todo.due_date < future
        current_todos << todo
      end
    end
    current_todos
  end
  
  def self.future_todos
    future_todos = Array.new
    future = Date.today >> 11
    Todo.all.each do |todo|
      if todo.due_date >= future
        future_todos << todo
      end
    end
    future_todos
  end
  
  # scope :no_frame_todos, where(:frame => nil)
  # scope :personal_todos, where(:frame => "personal")
  # and then use them in code like:
  # @no_frame_todos = Todo.no_frame_todos
  # @personal_todos = Todo.personal_todos
end