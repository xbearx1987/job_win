class Account::CollectionsController < ApplicationController

  def index
    @user = current_user
    @collections = Collection.where(:user => @user).order("created_at DESC").paginate(:page => params[:page], :per_page => 7)
    @suggests = Job.published.limit(5).random5
  end

end
