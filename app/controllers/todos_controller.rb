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
  
  
  def set_frame
    id = params[:id]
    frame = params[:frame]
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
  
  def index
    todos_by_frame = Todo.all.group_by(&:frame)
    @no_frame_todos = todos_by_frame[nil]
    @personal_todos = todos_by_frame["personal"]
    @family_todos = todos_by_frame["family"]
    @friends_todos = todos_by_frame["friends"]
    @work_todos = todos_by_frame["work"]
    @social_todos = todos_by_frame["social"]
  end

end