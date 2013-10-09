class CohortsController < ApplicationController
  before_filter :authenticate_user!

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
      redirect_to cohort_path(@cohort), notice: 'A new cohort has been created'
    else
      render :new
    end
  end

  def edit
    @cohort = Cohort.find(params[:id])
  end

  def update
    if @cohort.update(cohort_params)
      redirect_to cohort_path(@cohort), notice 'You have successfully updated the cohort'
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
