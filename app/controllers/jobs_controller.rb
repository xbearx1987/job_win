class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:add, :remove]
  before_action :validate_search_key, only: [:search]

  def index
    @locations = Location.published.sortA
    @categorys = Category.published.sortA

    # 随机推荐五个职位 #
    @suggests = Job.published.random5

    # 目前只能单个条件筛选 #
    # 判断是否筛选城市 #
    if params[:location].present?
      @location = params[:location]
      @location_id = Location.find_by(name: @location)

      if @location == '所有城市'
        @jobs = Job.published.recent.paginate(:page => params[:page], :per_page => 10)
      else
        @jobs = Job.where(:location => @location_id).published.recent.paginate(:page => params[:page], :per_page => 10)
      end

    # 判断是否筛选职位类型 #
    elsif params[:category].present?
      @category = params[:category]
      @category_id = Category.find_by(name: @category)

      if @category == '所有类型'
        @jobs = Job.published.recent.paginate(:page => params[:page], :per_page => 10)
      else
        @jobs = Job.where(:category => @category_id).published.recent.paginate(:page => params[:page], :per_page => 10)
      end

    # 判断是否筛选薪水 #
    elsif params[:wage].present?
      @wage = params[:wage]
      if @wage == '5k以下'
        @jobs = Job.wage1.published.recent.paginate(:page => params[:page], :per_page => 10)
      elsif @wage == '5~10k'
        @jobs = Job.wage2.published.recent.paginate(:page => params[:page], :per_page => 10)
      elsif @wage == '10~15k'
        @jobs = Job.wage3.published.recent.paginate(:page => params[:page], :per_page => 10)
      elsif @wage == '15~25k'
        @jobs = Job.wage4.published.recent.paginate(:page => params[:page], :per_page => 10)
      else
        @jobs = Job.wage5.published.recent.paginate(:page => params[:page], :per_page => 10)
      end

    # 预设显示所有公开职位 #
    else
      @jobs = Job.published.recent.paginate(:page => params[:page], :per_page => 10)
    end
  end

  def show
    @job = Job.find(params[:id])

    @category = @job.category
    # 随机推荐五个相同类型的职位（去除当前职位） #
    @sames = Job.where(:is_hidden => false, :category => @job.category).where.not(:id => @job.id ).random5
    # 搜索该用户投递此职位的简历数量 #
    @resumes = Resume.where(:job => @job, :user => current_user)

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
      # 显示符合关键字的公开职位 #
      search_result = Job.joins(:location).ransack(@search_criteria).result(:distinct => true)
      @jobs = search_result.published.paginate(:page => params[:page], :per_page => 10 )
      # 随机推荐五个职位 #
      @suggests = Job.published.random5
    end
  end

  protected

  def validate_search_key
    # 去除特殊字符 #
    @query_string = params[:keyword].gsub(/\\|\'|\/|\?/, "") if params[:keyword].present?
    @search_criteria = search_criteria(@query_string)

  end

  def search_criteria(query_string)
    # 筛选多个栏位 #
    { :name_or_company_or_location_name_cont => query_string }
  end

end
