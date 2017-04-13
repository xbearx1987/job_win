class JobsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]

  def index
    @jobs = Job.all
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user

    if @job.save
      redirect_to jobs_path, notice: '职缺新增成功。'
    else
      render :new
    end
  end

private

  def job_params
    params.require(:job).permit(:name,:content,:company,:category,:location,:wage_lower_bound,:wage_upper_bound,:contact_mail)
  end

end
