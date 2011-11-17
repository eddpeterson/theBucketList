class Goal
  include Mongoid::Document  
  field :title, type: String
  field :due_date, type: Date, default: Date.today
  field :frame, type: String
  field :frame_order_number, type: Integer
  field :status, type: String, default: "undone"
  
  embedded_in :user
  
  validates_presence_of :title
  
  #scope :past_goals, where(:due_date < Date.yesterday)
  
  def self.get_new(title, frame)
    todo = Goal.new
    todo.title = title
    todo.frame = frame
    todo.frame_order_number = 0
    todo.due_date = Date.today >> 10
    todo
  end
  # scope :no_frame_todos, where(:frame => nil)
  # scope :personal_todos, where(:frame => "personal")
  # and then use them in code like:
  # @no_frame_todos = Todo.no_frame_todos
  # @personal_todos = Todo.personal_todos
  
  def past?
    due_date <= Date.yesterday
  end
  
  def current?
    yesterday = Date.yesterday
    future = Date.today >> 11
    due_date > yesterday && due_date < future
  end
  
  def future?
    future = Date.today >> 11
    due_date >= future
  end
end