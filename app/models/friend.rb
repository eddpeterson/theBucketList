require 'cgi'

class Friend
  
  def self.find_my_facebook_friends(id, access_token)
    #puts " ...................... "
    #puts access_token['credentials']['token']
    #@graph = Koala::Facebook::API.new(access_token['credentials']['token'])        
    #     profile = @graph.get_object("me")
    #     puts profile
    #     friends = @graph.get_connections("me", "friends")
    #     puts friends
    
    
    #token = access_token['credentials']['token']
    uri = URI.parse("https://graph.facebook.com/#{id}/friends?access_token=#{CGI.escape(access_token)}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    
    request = Net::HTTP::Get.new(uri.path + "?" + uri.query)
    response = http.request(request)
    JSON.parse(response.body)['data'].map {|friend| friend['id']}     
    # data = JSON.parse(response.body)['data'].each  do |friend|
    #       puts friend['id'] + " " + friend['name']
    #     end
    #puts data        
    #url = "https://graph.facebook.com/#{id}/friends?access_token=#{CGI.escape(token)}"
    #response = Net::HTTP.get_response(URI.parse(url))
    #puts response.body
    #puts " ...................... "
    
  end
  
  
  
end