class ManageController < ApplicationController
  def handle
  	redirect_to :controller => "projects", :action => "manage_list"  if(params[:object]=="projects")
  end
end
