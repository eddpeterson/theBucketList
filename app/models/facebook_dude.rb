class FacebookDude
  def initialize(id, token)
    @id = id
    @token = token
  end
  def friends_ids
    uri = URI.parse("https://graph.facebook.com/#{@id}/friends?access_token=#{CGI.escape(@token)}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true    
    request = Net::HTTP::Get.new(uri.path + "?" + uri.query)
    response = http.request(request)
    JSON.parse(response.body)['data'].map {|friend| friend['id']}  
  end
end