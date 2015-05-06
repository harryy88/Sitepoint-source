class ProjectsController < ApplicationController
  load_and_authorize_resource
  skip_load_and_authorize_resource only: :index

  def index
    @projects = Project.order('created_at DESC')
    authorize! :index, @projects, message: 'You cannot access our projects. Perhaps, you should authenticate first.'
  end

  def new
    #@project = Project.new
    #authorize! :new, @project
  end

  def edit

  end

  def update
    if @project.update_attributes(project_params)
      flash[:success] = 'Project was updated!'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def create
    if @project.save
      flash[:success] = 'Project was saved!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    if @project.destroy
      flash[:success] = 'Project was destroyed!'
    else
      flash[:warning] = 'Cannot destroy this project...'
    end
    redirect_to root_path
  end

  private

  def project_params
    params.require(:project).permit(:title, :ongoing)
  end
end