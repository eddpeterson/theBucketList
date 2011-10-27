class TodosController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html  
  
  def create 
    frame = params[:frame]
    title = params[:title]
    current_user.todos << Todo.get_new(title, frame)
    
    #render :json => @todo
    #render "_frame", :frame_id => @frame_id
    todos = sort current_user.todos.where(frame: frame) # sort Todo.where(frame: frame)
    render :partial => "frame", :locals => { :frame_id => frame, :todos => todos }
  end
  
  def index
    todos_by_frame = current_user.todos.group_by(&:frame) #Todo.all.group_by(&:frame)
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
        todo = current_user.todos.find(id)
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
    todo = current_user.todos.find(id)
    todo.title = title
    todo.save
    render :nothing => true
  end
  
  def destroy
    id = params[:id]
    todo = current_user.todos.find(id)
    todo.delete
    render :nothing => true    
  end
  
private
  def sort (todos)
    unless todos.nil?
      todos.sort {|a,b| a.frame_order_number <=> b.frame_order_number}
    end
  end
  
end