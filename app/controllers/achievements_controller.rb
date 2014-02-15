class AchievementsController < ApplicationController
	before_action :set_achievement, only: [:show, :update, :destroy, :edit]
  before_action :set_user, only: [:show, :create, :edit, :manage_list, :manage_tag, :update]
  before_action :set_achievements, only: [:manage_list, :manage_tag]
  before_action :set_meta

  # GET /achievements
  # GET /achievements.json
  def index
    @achievements = Achievement.all
  end

  # GET /achievements/1
  # GET /achievements/1.json
  def show
    @back_link = @@manage_page if flash[:burst_back]
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /achievements/new
  def new
    @achievement = Achievement.new
    # params[:_local_user] = User.find_by_id(session[:user_id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /achievements/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /achievements
  # POST /achievements.json
  def create
    @achievement = Achievement.new(achievement_params)
    respond_to do |format|
      begin
        Achievement.transaction do
          @achievement.save!
        end
        @back_link = @@manage_page
        format.html {render action: 'show'}
        format.js {render action: 'show'}
      rescue Exception => e
        format.html { render action: 'edit' }
        format.json { render json: @achievement.errors, status: :unprocessable_entity }
        format.js {render text: "alert('#{@achievement.errors}')"}
      end
    end
  end

  # PATCH/PUT /achievements/1
  # PATCH/PUT /achievements/1.json
  def update
    respond_to do |format|
      begin
        achievement.transaction do
          @achievement.update(achievement_params)
        end
        format.html { redirect_to @achievement, flash: { burst_back:true } }
        format.json { head :no_content }
        format.js {render action: 'show'}
      rescue Exception => e
        format.html { render action: 'edit' }
        format.json { render json: @achievement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /achievements/1
  # DELETE /achievements/1.json
  def destroy
    @achievement.destroy
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.json { head :no_content }
    end
  end

  def manage_list
    @@manage_page = achievement_manage_list_path
    render "shared/manage_list"
  end  

  def manage_tag
    @@manage_page = achievement_manage_tag_path
    render "shared/manage_tag"
  end

  private
    @@manage_page = AchievementsController.instance_method(:achievement_manage_list_path)
    # Use callbacks to share common setup or constraints between actions.
    def set_meta
      @header_meta = "成果管理"
      @obj_name = get_obj_name
      @obj_list_metas = [
        {title: "成果标题", attri: :title},
        {title: "简介", attri: :description, 
          callback: {handler: :get_brief_text, params: 10}
        }
      ]      
      @obj_list_metas = [
        {title: "成果标题", attri: :title},
        {title: "简介", attri: :description, 
          callback: {handler: :get_brief_text, params: 10}
        }
      ]
      @obj_tag_metas = [
        :description,
        []
      ]
    end

    def set_user
      @user = User.find(session[:user_id])
    end

    def set_achievements
      @achievements = @user.achievements.to_a
      @objects = @achievements
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_achievement
      # p params
      @achievement = Achievement.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def achievement_params
    	params[:achievement][:user_id] = @user.id
      params.require(:achievement).permit(:title, :description, :user_id)
    end
end
