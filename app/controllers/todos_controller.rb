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
    respond_with(@todos)
  end

end