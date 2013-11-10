class WelcomeController < ApplicationController
  def index
  	@user = User.find_by(id: session[:user_id])
  	respond_to do |format|
        format.html
        format.js
        format.json
    end
  end
end
