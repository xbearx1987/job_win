class Admin::LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_website_admin

  layout "admin"

  def index
    @locations = Location.all.sortA
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)

    # 新增数据的排序为目前最大排序再 +1 #
    @location.sort = Location.sortD.first.sort + 1

    if @location.save
      redirect_to admin_locations_path, notice: "工作地点新增成功。"
    else
      render :new
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    @location.update(location_params)

    if @location.save
      redirect_to admin_locations_path, notice: "工作地点修改成功。"
    else
      render :edit
    end
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

  def up
    @location = Location.find(params[:id])
    @locationX = Location.find_by(:sort => @location.sort - 1)
    @location.sort -= 1

    # 排序数字必须大于 0 #
    if @location.sort > 0
      @location.save
    end

    # 如果有比当前排序小一个数字的数据时，将该数据排序 +1（排序位置交换） #
    if @locationX.present?
      @locationX.sort += 1
      @locationX.save
    end

    redirect_to :back
  end

  def down
    @location = Location.find(params[:id])
    @locationX = Location.find_by(:sort => @location.sort + 1)
    @location.sort += 1
    @location.save

    # 如果有比当前排序大一个数字的数据时，将该数据排序 -1（排序位置交换） #
    if @locationX.present?
      @locationX.sort -= 1
      @locationX.save
    end

    redirect_to :back
  end

private

  def location_params
    params.require(:location).permit(:name,:is_hidden)
  end

end
