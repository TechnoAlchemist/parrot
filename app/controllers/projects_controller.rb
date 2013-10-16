class ProjectsController < ApplicationController
  before_filter :set_cohort
  before_filter :set_project, only: [:edit, :update, :generate, :show, :destroy]

  def index
    @projects = Project.where(cohort_id: @cohort.id)
  end

   def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.cohort = @cohort
    if @project.save
      flash[:notice] = "Project successfully created"
      redirect_to cohort_project_path(@cohort, @project)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      flash[:notice] = 'Project successfully edited'
      redirect_to cohort_project_path(@cohort, @project)
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    if @project.destroy
      redirect_to cohort_projects_path(@cohort)
    end
  end

  def generate
    size = params['Group Size'].to_i
    @project.sort_random_pairs(size)

    redirect_to cohort_project_path(@cohort, @project)
  end

  protected

  def project_params
    params.require(:project).permit(:title, :link)
  end

  def set_cohort
    @cohort = Cohort.find(params[:cohort_id])
  end

  def set_project
    @project = Project.find(params[:id])
  end

end
