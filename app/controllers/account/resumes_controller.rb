class Account::ResumesController < ApplicationController

  def index
    @user = current_user
    @resumes = Resume.where(:user_id => @user).order("created_at DESC").paginate(:page => params[:page], :per_page => 7)
    @suggests = Job.published.random5
  end

end
