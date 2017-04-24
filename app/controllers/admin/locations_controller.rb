class Admin::LocationsController < ApplicationController

  def index
    @locations = Location.all
  end

  def publish
    @location = Location.find(params[:id])
    @location.is_hidden = false
    @location.save
    redirect_to :back
  end

  def hide
    @location = Location.find(params[:id])
    @location.is_hidden = true
    @location.save
    redirect_to :back
  end
end
