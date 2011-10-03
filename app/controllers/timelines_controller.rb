class TimelinesController < ApplicationController
  respond_to :html  
  
  def index
    @past_todos = Todo.past_todos
    @current_todos = Todo.current_todos
    @future_todos = Todo.future_todos
  end
  
end