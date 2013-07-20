module AuthHelper
  
  def http_login
    user = HTTP_AUTH_USER
    pw = HTTP_AUTH_PASSWORD
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end  
end