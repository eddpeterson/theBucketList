class FacebookDude
  
  def self.friends id, token
    uri = URI.parse("https://graph.facebook.com/#{id}/friends?access_token=#{CGI.escape(token)}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true    
    request = Net::HTTP::Get.new(uri.path + "?" + uri.query)
    response = http.request(request)
    facebook_friend_ids = JSON.parse(response.body)['data'].map {|friend| friend['id']}
    
    friends = User.any_in("_id" => facebook_friend_ids)
    friends
  end
  

end