module FacebookInfo
  def facebook_info id, token
    uri = URI.parse("https://graph.facebook.com/#{id}?access_token=#{CGI.escape(token)}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true    
    request = Net::HTTP::Get.new(uri.path + "?" + uri.query)
    response = http.request(request)    
    JSON.parse(response.body)
  end
end