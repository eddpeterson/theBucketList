class TimelinesController < ApplicationController
  respond_to :html  
  
  def index
    @past_todos = Todo.past_todos
    @current_todos = Todo.current_todos
    @future_todos = Todo.future_todos
  end
  
  def set_status
    status = params[:status]
    id = params[:id]
    
    todo = Todo.find(id)
    todo.status = status
    todo.save
    
    render :nothing => true
  end
  
  def progress
    render :text => Todo.done_todos_percentage
  end
  
end