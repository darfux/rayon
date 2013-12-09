module ApplicationHelper
  def get_user
    User.find_by_id(session[:user_id])
  end
  def save_referer
    if request.referer != request.url
      session[:return_to] = request.referer
    end
  end
  def save_now
    session[:return_to] = request.url
  end
  def link_back(name)
    link_to name, get_back_link
  end
  def get_back_link
    request.env["HTTP_REFERER"].blank? ? "/" : request.env["HTTP_REFERER"]
  end
end
