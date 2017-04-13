class JobsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  before_action :find_job_and_check_permission , only: [:edit, :update, :destroy]

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

  def edit
  end

  def update
    @job.update(job_params)

    if @job.save
      redirect_to jobs_path, notice: '职缺修改成功。'
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
      redirect_to jobs_path, alert: '职缺删除成功。'
  end

private

  def find_job_and_check_permission
    @job = Job.find(params[:id])

    if @job.user != current_user
      redirect_to root_path, alert: "你没有权限进行此操作。"
    end
  end

  def job_params
    params.require(:job).permit(:name,:content,:company,:category,:location,:wage_lower_bound,:wage_upper_bound,:contact_mail)
  end

end
