class Todo
  include Mongoid::Document  
  field :title, type: String
  field :due_date, type: Date
end