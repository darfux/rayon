class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy, :edit]
  before_action :set_user, only: [:show, :create, :manage_list, :manage_tag, :update]
  before_action :set_projects, only: [:manage_list, :manage_tag]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    respond_to do |format|
      format.js
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
    params[:_local_user] = User.find_by_id(session[:user_id])
    respond_to do |format|
        format.js
    end
  end

  # GET /projects/1/edit
  def edit
    respond_to do |format|
        format.js
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    p params[:participation_type_id]
    respond_to do |format|
      begin
        Project.transaction do
          @project.save
          @project.project_users.create!({user_id: @user.id,
            participation_type_id: params[:participation_type_id]})
        end
        format.js {render action: 'show'}
      rescue Exception => e
        format.js {render text: "alert('#{@project.errors}')"}
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.js {render action: 'show'}
      else
        format.js {render text: "alert('#{@project.errors}')"}
        # format.html { render action: 'edit' }
        # format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.json { head :no_content }
    end
  end

  def manage_list
    respond_to do |format|
      format.js
    end
  end  

  def manage_tag
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(session[:user_id])
    end

    def set_projects
      @projects = @user.projects.to_a
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      # p params
      @project = Project.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :start, :end, 
        :source_id, :project_type_id, :project_state_id)
    end
end
