class Account::CollectionsController < ApplicationController

  def index
    @user = current_user
    @collections = Collection.where(:user => @user).order("created_at DESC")
  end

end
