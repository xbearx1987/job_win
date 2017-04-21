class Admin::JobsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  before_action :find_job_and_check_permission , only: [:edit, :update, :destroy]
  before_action :require_is_admin

  layout "admin"

  def index
    # 目前只能单个条件筛选 #
    # 判断是否筛选城市 #
    if params[:location].present?
      @location = params[:location]
      if @location == '所有城市'
        @jobs = Job.where(:user => current_user).published.recent.paginate(:page => params[:page], :per_page => 10)
      else
        @jobs = Job.where(:user => current_user).where(:is_hidden => false, :location => @location).recent.paginate(:page => params[:page], :per_page => 10)
      end

    # 判断是否筛选职位类型 #
    elsif params[:category].present?
      @category = params[:category]
      if @category == '所有类型'
        @jobs = Job.where(:user => current_user).published.recent.paginate(:page => params[:page], :per_page => 10)
      else
        @jobs = Job.where(:user => current_user).where(:is_hidden => false, :category => @category).recent.paginate(:page => params[:page], :per_page => 10)
      end

    # 判断是否筛选薪水 #
    elsif params[:wage].present?
      @wage = params[:wage]
      if @wage == '5k以下'
        @jobs = Job.where(:user => current_user).wage1.recent.paginate(:page => params[:page], :per_page => 10)
      elsif @wage == '5~10k'
        @jobs = Job.where(:user => current_user).wage2.recent.paginate(:page => params[:page], :per_page => 10)
      elsif @wage == '10~15k'
        @jobs = Job.where(:user => current_user).wage3.recent.paginate(:page => params[:page], :per_page => 10)
      elsif @wage == '15~25k'
        @jobs = Job.where(:user => current_user).wage4.recent.paginate(:page => params[:page], :per_page => 10)
      else
        @jobs = Job.where(:user => current_user).wage5.recent.paginate(:page => params[:page], :per_page => 10)
      end

    # 预设显示所有公开职位 #
    else
      @jobs = Job.where(:user => current_user).recent.paginate(:page => params[:page], :per_page => 10)
    end
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
      redirect_to admin_jobs_path, notice: '职位新增成功。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @job.update(job_params)

    if @job.save
      redirect_to admin_jobs_path, notice: '职位修改成功。'
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
      redirect_to admin_jobs_path, alert: '职位删除成功。'
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
