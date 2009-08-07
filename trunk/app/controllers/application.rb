# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionNotifiable
  include AuthenticatedSystem
  include RoleRequirementSystem

  # HTTP Basic Auth for closed groups
  #USER_NAME, PASSWORD = "cck", "secret"
  #before_filter :authenticate

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '45102358f5666cda23b50cbd772a473f'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password, :password_confirmation

  private
  
    def authenticate
      authenticate_or_request_with_http_basic APP_CONFIG[:site_name] do |user_name, password| 
        (user_name == USER_NAME && password == PASSWORD) || current_user
      end
    end
end
