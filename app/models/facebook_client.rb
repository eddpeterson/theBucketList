# class FBClient
# 
#       def initialize(app, access_token = nil)
#         @app = app
#         @access_token = access_token
#       end
# 
#       # request permission(s) from user
#       def request(perms)
#         #create a random verifier to identify user on fb callback
#         verifier = (0...10).map{65.+(rand(25)).chr}.join
#         uri = "https://graph.facebook.com/oauth/authorize?client_id=#{@app.app_id}&redirect_uri=#{@app.connect_url}?verifier=#{verifier}&scope=#{perms}"
# 
#         request = { :verifier => verifier, :uri => uri }
#         return request
# 
#       end
# 
#       def connect(code, verifier)
# 
#         uri = URI.parse("https://graph.facebook.com/oauth/access_token?client_id=#{@app.app_id}&redirect_uri=#{@app.connect_url}?verifier=#{verifier}&client_secret=#{@app.secret}&code=#{CGI::escape(code)}")
#         http = Net::HTTP.new(uri.host, uri.port)
#         http.use_ssl = true
# 
#         request = Net::HTTP::Get.new(uri.path + "?" + uri.query)
#         response = http.request(request)     
#         data = response.body
# 
#         return data.split("=")[1]
#       end
# 
#       # get, post
#       def get(path, params = nil)
#         uri = URI.parse("https://graph.facebook.com/" + path)
#         http = Net::HTTP.new(uri.host, uri.port)
#         http.use_ssl = true
# 
#         if params.nil?
#           params = Hash.new
#         end
# 
#         if params["access_token"].nil? 
#           params["access_token"] = @access_token unless @access_token.nil?
#         end
# 
#         request = Net::HTTP::Get.new(uri.path) 
#         request.set_form_data( params )
#         request = Net::HTTP::Get.new(uri.path + "?" + request.body)
# 
#         return response = http.request(request)
#       end
# 
#       def post(path, params = nil)
#         uri = URI.parse("https://graph.facebook.com/" + path)
#         http = Net::HTTP.new(uri.host, uri.port)
#         http.use_ssl = true        
# 
#         if params.nil?
#           params = Hash.new
#         end
# 
#         if params[:access_token].nil?
#           params[:access_token] = @access_token unless @access_token.nil?
#         end
# 
#         request = Net::HTTP::Post.new(uri.path) 
#         request.set_form_data( params )
#         request = Net::HTTP::Post.new(uri.path + "?" + request.body)
# 
#         response = http.request(request)
#         response.code == "200" ? feed = JSON.parse(response.body) : raise("Sorry, an error occured. #{response.body}")
#         return feed
#       end
#     end