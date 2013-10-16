class ProjectsController < ApplicationController  
  def index
    @projects = Project.where(cohort_id: params[:cohort_id])
    @cohort = Cohort.find(params[:cohort_id])
  end

   def new
    @project = Project.new
    @cohort = Cohort.find(params[:cohort_id])
    if signed_in?
      @project = Project.new
      @cohort = Cohort.find(params[:cohort_id])
    else
      flash[:notice] = "You need to sign in before continuing"
    end
  end

  def create
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
    @cohort = Cohort.find(params[:cohort_id])
    # binding.pry
    if current_user && current_user.role == "admin"
      @project = Project.find(params[:id])
      @cohort = Cohort.find(params[:cohort_id])
    else
      flash[:notice] = "You do not have permission to edit projects"
      redirect_to cohort_projects_path
    end
   end

  def update
    @project = Project.find(params[:id])
    @cohort = Cohort.find(params[:cohort_id])

    if @project.update(project_params)
      flash[:notice] = 'Project successfully edited'
      redirect_to cohort_project_path(@cohort, @project)
    else
      render :edit
    end
  end

  def show
     @project = Project.find(params[:id])
     @cohort = Cohort.find(params[:cohort_id])
  end

  def destroy
    @project = Project.find(params[:id])
    @cohort = Cohort.find(params[:cohort_id])
    if @project.destroy
      redirect_to :cohort_projects
    end
  end

  def project_params
    params.require(:project).permit(:title, :link)
  end

end
