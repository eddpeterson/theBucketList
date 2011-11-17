class TimelinesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html  
  
  def index
    @past_goals = current_user.past_goals
    @current_goals = current_user.current_goals
    @future_goals = current_user.future_goals
  end
  
  def set_status
    status = params[:status]
    id = params[:id]
    
    goal = current_user.goals.find(id)
    goal.status = status
    goal.save
    
    render :nothing => true
  end

  def set_due_date
    id = params[:id]
    due_date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    
    goal = current_user.goals.find(id)
    goal.due_date = due_date
    goal.save
    
    render json: { past: goal.past?, current: goal.current?, future: goal.future?, append_to_goal_id: current_user.append_to_goal_id(goal) }
  end
  
  def progress
    render :text => current_user.done_goals_percentage
  end
  
end