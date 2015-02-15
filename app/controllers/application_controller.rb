class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :authorize
  before_filter :set_browser_type


  def set_browser_type
    @browser_type = detect_browser
  end

  protected
    def authorize
      unless User.find_by_id(session[:user_id])
        redirect_to root_url
      end
    end

    def get_obj_name
      return self.class.to_s[0..-11].downcase.singularize
    end

  private
    
  MOBILE_BROWSERS = ["playbook", "windows phone", "android", "ipod", "iphone", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker", "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile", "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle", "mobile","pda","psp","treo"]

  def detect_browser
    agent = request.headers["HTTP_USER_AGENT"].downcase
  
    MOBILE_BROWSERS.each do |m|
      return :mobile if agent.match(m)
    end
    return :desktop
  end
end
