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
  def history_back_url(backup_path = request.referer)
    result = ""
    if session[:return_to]
      result = session[:return_to]
    else
      result = backup_path
    end
    return result
  end
end
