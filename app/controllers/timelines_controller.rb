class TimelinesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html  
  
  def index
    @past_todos = current_user.past_todos
    @current_todos = current_user.current_todos
    @future_todos = current_user.future_todos
  end
  
  def set_status
    status = params[:status]
    id = params[:id]
    
    todo = current_user.todos.find(id)
    todo.status = status
    todo.save
    
    render :nothing => true
  end
  
  def set_due_date
    id = params[:id]
    due_date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    
    todo = current_user.todos.find(id)
    todo.due_date = due_date
    
    todo.save
    
    render :nothing => true
  end
  
  def progress
    render :text => current_user.done_todos_percentage
  end
  
end