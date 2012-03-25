class GoalsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html  
  
  def create 
    #logger.info "Create goal: #{params}"
    logger.debug "Create goal: #{params}"
    
    frame = params[:frame]
    title = params[:title]
    goal = Goal.get_new(title, frame)
    current_user.add_goal(goal)
    
    #render :json => @goal
    #render "_frame", :frame_id => @frame_id
    render :partial => "goal", :locals => { :goal_id => goal.id, :goal_title => title }, content_type: "text/html"
  end
  
  def index
    goals_by_frame = current_user.goals.group_by(&:frame) #Goal.all.group_by(&:frame)
    @personal_goals = sort goals_by_frame["personal"]
    @family_goals = sort goals_by_frame["family"]
    @friends_goals = sort goals_by_frame["friends"]
    @work_goals = sort goals_by_frame["work"]
    @social_goals = sort goals_by_frame["social"]
  end
  
  
  
  def set_sorting
    sorted_goals = params[:sorted_goals]
    unless sorted_goals.nil?
      frame = params[:frame]
      order_number = 1
      sorted_goals.each do |id|
        goal = current_user.goals.find(id)
        goal.frame = frame
        goal.frame_order_number = order_number
        order_number += 1
        goal.save
      end
    end
    render :nothing => true
  end
  
  def rename
    id = params[:id]
    title = params[:title]
    goal = current_user.goals.find(id)
    goal.title = title
    goal.save
    render :nothing => true
  end
  
  def destroy
    id = params[:id]
    current_user.remove_goal(id)
    render :nothing => true    
  end
  
private
  def sort (goals)
    unless goals.nil?
      goals.sort {|a,b| a.frame_order_number <=> b.frame_order_number}
    end
  end
  
end