class ProjectsController < ApplicationController  
  def index
    @projects = Project.where(cohort_id: params[:cohort_id])
    @cohort = Cohort.find(params[:cohort_id])
  end

   def new
    @project = Project.new
    @cohort = Cohort.find(params[:cohort_id])
  end

  def create
    # binding.pry
    @project = Project.new(project_params)
    @cohort = Cohort.find(params[:cohort_id])
    @project.cohort = @cohort
    if @project.save 
      flash[:notice] = "Project successfully created"
      redirect_to cohort_project_path(@cohort, @project)
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def show
    # binding.pry
     @project = Project.find(params[:id])
     @cohort = Cohort.find(params[:cohort_id])
  end

  def destroy
     @project = Project.find(params[:id])
     @cohort = Cohort.find(params[:cohort_id])

    if @project.destroy
      redirect_to cohort_projects_path(@cohort)
    end
  end

  def project_params
    params.require(:project).permit(:title, :link)
  end

end
