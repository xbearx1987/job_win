class Account::ResumesController < ApplicationController

  def index
    @user = current_user
    @resumes = Resume.where(:user_id => @user).order("created_at DESC")
  end

end
