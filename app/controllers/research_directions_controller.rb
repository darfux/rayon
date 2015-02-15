class ResearchDirectionsController < ApplicationController
	before_action :set_user, only:[:create, :destroy]
	def show
	end
	# POST /research_directions
  def create
  	name = params[:name]
  	unless direction=ResearchDirection.find_by_name(name)
  		direction = ResearchDirection.new({name: name})
  		direction.save!
  	end
  	relation = {research_direction_id: direction.id, user_id: @user.id}
  	ResearchDirectionsUsers.find_or_create_by!(relation)
  	redirect_to @user
  end

  def destroy
  	ResearchDirectionsUsers.find_by(
  		{research_direction_id: params[:id], user_id: @user.id}
  		).destroy
  	redirect_to @user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(session[:user_id])
    end

    def set_research_direction
      @research_direction = ResearchDirection.find_by_id(params[:id])
    end
end
