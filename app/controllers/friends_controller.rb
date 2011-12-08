class FriendsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html  
  
  def index
    @friends = current_user.friends
    unless @friends.count != 0
      render "empty_friends"
    end
  end
  
end