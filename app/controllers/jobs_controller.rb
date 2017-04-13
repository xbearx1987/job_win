class JobsController < ApplicationController

  def index
    @jobs = Job.where(:is_hidden => false).order("created_at DESC")
  end

  def show
    @job = Job.find(params[:id])

    if @job.is_hidden
      redirect_to root_path, alert: "此职缺暂未开放。"
    end
  end

end
