class SessionsController < Devise::SessionsController
  
  def create
    id = params[:user_id]
    access_token = params[:access_token]
    user = User.find_or_create(id, access_token)
    sign_in user
    render :json => {:success => true}
  end

end