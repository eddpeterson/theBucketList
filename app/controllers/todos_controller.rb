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
    @todos = Todo.all
    
    @no_frame_todos = Array.new
    @personal_todos = Array.new
    @family_todos = Array.new
    @friends_todos = Array.new
    @todos.each do |doc| 
      
      if doc.frame == nil 
        @no_frame_todos << doc 
      end
      if doc.frame == "personal" 
        @family_todos << doc 
      end
      if doc.frame == "family" 
        @family_todos << doc 
      end
      if doc.frame == "friends" 
        @friends_todos << doc 
      end
      
    end  
    
  end

end