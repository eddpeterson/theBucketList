class GoalsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html  
  
  def create 
    frame = params[:frame]
    title = params[:title]
    current_user.goals << Goal.get_new(title, frame)
    
    #render :json => @goal
    #render "_frame", :frame_id => @frame_id
    goals = sort current_user.goals.where(frame: frame) # sort Goal.where(frame: frame)
    render :partial => "frame", :locals => { :frame_id => frame, :goals => goals }
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
    goal = current_user.goals.find(id)
    goal.delete
    render :nothing => true    
  end
  
private
  def sort (goals)
    unless goals.nil?
      goals.sort {|a,b| a.frame_order_number <=> b.frame_order_number}
    end
  end
  
end