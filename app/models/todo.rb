class Todo
  include Mongoid::Document  
  field :title, type: String
  field :due_date, type: Date
  field :frame, type: String
  field :frame_order_number, type: Integer
  
  # scope :no_frame_todos, where(:frame => nil)
  # scope :personal_todos, where(:frame => "personal")
  # and then use them in code like:
  # @no_frame_todos = Todo.no_frame_todos
  # @personal_todos = Todo.personal_todos
end