class TodosController < ApplicationController
  respond_to :html  
  
  def new
    @todo = Todo.new
    respond_with(@todo)
  end
  
  def create 
    @todo = Todo.new(params[:todo])
    respond_to do |format|
      if @todo.save
        flash[:notice] = "#{@todo.title} added to your bucket list"
        format.html { redirect_to :action => "index" }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def index
    todos_by_frame = Todo.all.group_by(&:frame)
    @no_frame_todos = sort todos_by_frame[nil]
    @personal_todos = sort todos_by_frame["personal"]
    @family_todos = sort todos_by_frame["family"]
    @friends_todos = sort todos_by_frame["friends"]
    @work_todos = sort todos_by_frame["work"]
    @social_todos = sort todos_by_frame["social"]
  end
  

  def set_frame
    id = params[:id]
    frame = params[:frame]
    if frame == "none"
      frame = nil
    end
    todo = Todo.find(id)
    todo.frame = frame
    respond_to do |format|
      if todo.save
        flash[:notice] = "wadaaaaaaaaaaaa!!!"
        format.html { redirect_to :action => "index" }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def set_sorting
    sorted_todos = params[:sorted_todos]
    frame = params[:frame]
    order_number = 1
    sorted_todos.each do |id|
      todo = Todo.find(id)
      todo.frame_order_number = order_number
      order_number += 1
      todo.save
    end
  end
  
private
  def sort (todos)
    unless todos.nil?
      todos.sort {|a,b| a.frame_order_number <=> b.frame_order_number}
    end
  end
  
end