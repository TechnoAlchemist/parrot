class CohortsController < ApplicationController

  def index
    @cohorts = Cohort.all
  end

  def new
    @cohort = Cohort.new
  end

  def show
    @cohort = Cohort.find(params[:id])
  end

  def create
    @cohort = Cohort.new(cohort_params)
    if @cohort.save
      flash[:notice] = 'A new cohort has been created'
      redirect_to cohort_path(@cohort)
    else
      render :new
    end
  end

  def edit
    @cohort = Cohort.find(params[:id])
  end

  def update
    @cohort = Cohort.find(params[:id])
    if @cohort.update(cohort_params)
      flash[:notice] = 'You have successfully updated the cohort'
      redirect_to cohort_path(@cohort)
    else
      render :new
    end
  end

  def destroy
    @cohort = Cohort.find(params[:id])
    if @cohort.destroy
      redirect_to cohorts_path
    end
  end

  protected
    def cohort_params
      params.require(:cohort).permit(:term)
    end
end
