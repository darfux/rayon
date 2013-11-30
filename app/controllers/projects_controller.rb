class ProjectsController < ApplicationController
  # before_action :set_project, only: [:show, :update, :destroy]
  before_action :set_user, only: [:manage_list, :manage_tag]
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
      format.html
      format.js
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
    params[:_local_user] = User.find_by(id: session[:user_id])
    render
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
    project_params[:user_id] = session[:user_id]
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
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
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :user_id, :year, :source)
    end
end
