class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def about
    
  end
  
  
  def fake_log_in 
    if Rails.env.test?
      user = User.create(:id => params['id'], :email => params['email'], :token => params['token'])
      sign_in user
      puts "current user: "
      puts current_user
      puts " "
    end
    # if current_user.nil?  
    #   sign_in User.create(:id => "123", :email => "123@example.com", :token => "token123")
    # end
    # puts current_user
    render :nothing => true
  end
   
  

end
