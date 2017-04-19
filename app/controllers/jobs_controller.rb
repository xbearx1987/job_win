class JobsController < ApplicationController
  before_action :authenticate_user! , only: [:add, :remove]
  before_action :validate_search_key, only: [:search]

  def index
    @jobs = Job.where(:is_hidden => false).order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    @suggests = Job.where(:is_hidden => false).limit(5).order("RANDOM()")
  end

  def show
    @job = Job.find(params[:id])

    @category = @job.category
    @sames = Job.where(:is_hidden => false, :category => @job.category).where.not(:id => @job.id ).limit(5).order("RANDOM()")

    if @job.is_hidden
      redirect_to root_path, alert: "此职缺暂未开放。"
    end
  end

  def add
    @job = Job.find(params[:id])

    if !current_user.is_member_of?(@job)
      current_user.add_collection!(@job)
    end

    redirect_to :back
  end

  def remove
    @job = Job.find(params[:id])

    if current_user.is_member_of?(@job)
      current_user.remove_collection!(@job)
    end

    redirect_to :back
  end



  def search
    if @query_string.present?
      search_result = Job.ransack(@search_criteria).result(:distinct => true)
      @jobs = search_result.paginate(:page => params[:page], :per_page => 15 )
      @suggests = Job.where(:is_hidden => false).limit(5).order("RANDOM()")
    end
  end

  protected

  def validate_search_key
    @query_string = params[:keyword].gsub(/\\|\'|\/|\?/, "") if params[:keyword].present?
    @search_criteria = search_criteria(@query_string)
  end

  def search_criteria(query_string)
    { :name_or_company_or_location_cont => query_string }
  end

end
