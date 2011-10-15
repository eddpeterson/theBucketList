class FriendsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html  
  
  def index
    @friends = current_user.friends
  end
  
end