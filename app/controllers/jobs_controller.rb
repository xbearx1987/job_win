class JobsController < ApplicationController
  before_action :authenticate_user! , only: [:add, :remove]

  def index
    @jobs = Job.where(:is_hidden => false).order("created_at DESC")
  end

  def show
    @job = Job.find(params[:id])

    if @job.is_hidden
      redirect_to root_path, alert: "此职缺暂未开放。"
    end
  end

  def add
    @job = Job.find(params[:id])

    if !current_user.is_member_of?(@job)
      current_user.add_collection!(@job)
    end

    redirect_to job_path(@job)
  end

  def remove
    @job = Job.find(params[:id])

    if current_user.is_member_of?(@job)
      current_user.remove_collection!(@job)
    end

    redirect_to job_path(@job)
  end

end
