class Admin::JobsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  before_action :find_job_and_check_permission , only: [:edit, :update, :destroy]
  before_action :require_is_admin

  layout "admin"

  def index
    @jobs = Job.where(:user => current_user).order("created_at DESC")
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
      redirect_to admin_jobs_path, notice: '职缺新增成功。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @job.update(job_params)

    if @job.save
      redirect_to admin_jobs_path, notice: '职缺修改成功。'
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
      redirect_to admin_jobs_path, alert: '职缺删除成功。'
  end

  def publish
    @job = Job.find(params[:id])
    @job.is_hidden = false
    @job.save
    redirect_to :back
  end

  def hide
    @job = Job.find(params[:id])
    @job.is_hidden = true
    @job.save
    redirect_to :back
  end

private

  def find_job_and_check_permission
    @job = Job.find(params[:id])

    if @job.user != current_user
      redirect_to root_path, alert: "你没有权限进行此操作。"
    end
  end

  def job_params
    params.require(:job).permit(:name,:content,:company,:category,:location,:wage_lower_bound,:wage_upper_bound,:contact_mail,:is_hidden)
  end

end
