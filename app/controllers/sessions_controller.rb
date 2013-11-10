class SessionsController < ApplicationController
  def new
    if session[:user_id]
      redirect_to welcome_path
      return
    end
  end

  def create
    user = User.find_by(uid: params[:uid])#not the name
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to welcome_path
    else
      if user
        redirect_to root_path, flash: {pswwr: "密码错误"}
      else
        redirect_to root_path, flash: {uidwr: "Uid不存在"}
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out"
  end
end
