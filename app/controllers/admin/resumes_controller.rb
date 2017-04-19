class Admin::ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_admin

  layout 'admin'

  def index
    @job = Job.find(params[:job_id])
    @resumes = @job.resumes.order('created_at DESC').paginate(:page => params[:page], :per_page => 3)
  end
end
