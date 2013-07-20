module AuthHelper
  
  # These are the constants used by the controller
  HTTP_AUTH_USER = 'username'
  HTTP_AUTH_PASSWORD = 'password'
  
  def http_login
    user = HTTP_AUTH_USER
    pw = HTTP_AUTH_PASSWORD
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end  
end