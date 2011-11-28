# require 'spec_helper'
# 
# describe FriendsController do
#   
#   include LoginMacros
#   let(:user) { User.create!(:id => "1", :email => "e@e.com", :password => "password") }
#   
#   it "should display loged in facebook users facebook friends using The Bucket List", :js => true do
#     friend = Factory(:user)
#     #FacebookDude.stub!(:friends).and_return([friend])
#     
#     user.stub!(:friends_ids).with(user.id, user.token).and_return([friend.id])
#     login_facebook user
#     
#     visit friends_path
#     page.should have_content(friend.name)
# 
#   end
# 
# end
