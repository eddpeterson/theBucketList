class TodosController < ApplicationController
  respond_to :html  
  
  def new
    @todo = Todo.new
    respond_with(@todo)
  end
  
  def create 
    frame = params[:frame]
    todo = Todo.new
    todo.title = params[:title]
    todo.frame = frame
    todo.frame_order_number = 0
    todo.save
    
    #render :json => @todo
    #render "_frame", :frame_id => @frame_id
    todos = sort Todo.where(frame: frame)
    render :partial => "frame", :locals => { :frame_id => frame, :todos => todos }
  end
  


  
  
  def index
    todos_by_frame = Todo.all.group_by(&:frame)
    @personal_todos = sort todos_by_frame["personal"]
    @family_todos = sort todos_by_frame["family"]
    @friends_todos = sort todos_by_frame["friends"]
    @work_todos = sort todos_by_frame["work"]
    @social_todos = sort todos_by_frame["social"]
  end
  
  
  
  def set_sorting
    sorted_todos = params[:sorted_todos]
    unless sorted_todos.nil?
      frame = params[:frame]
      order_number = 1
      sorted_todos.each do |id|
        todo = Todo.find(id)
        todo.frame = frame
        todo.frame_order_number = order_number
        order_number += 1
        todo.save
      end
    end
    render :nothing => true
  end
  
  def rename
    id = params[:id]
    title = params[:title]
    todo = Todo.find(id)
    todo.title = title
    todo.save
    render :nothing => true
  end
  
  def destroy
    id = params[:id]
    todo = Todo.find(id)
    todo.delete
    render :nothing => true    
  end
  
  def timeline
    @past_todos = Todo.past_todos
    @current_todos = Todo.current_todos
  end
  
  def show
    render :timeline
  end
  
private
  def sort (todos)
    unless todos.nil?
      todos.sort {|a,b| a.frame_order_number <=> b.frame_order_number}
    end
  end
  
end