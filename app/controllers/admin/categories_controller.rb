class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_website_admin

  layout "admin"

    def index
      @categorys = Category.all.sortA
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)

      # 新增数据的排序为目前最大排序再 +1 #
      @category.sort = Category.sortD.first.sort + 1

      if @category.save!
        redirect_to admin_categories_path, notice: "职位类型新增成功。"
      else
        render :new
      end
    end

    def edit
      @category = Category.find(params[:id])
    end

    def update
      @category = Category.find(params[:id])
      @category.update(category_params)

      if @category.save
        redirect_to admin_categories_path, notice: "职位类型修改成功。"
      else
        render :edit
      end
    end

    def publish
      @category = Category.find(params[:id])
      @category.is_hidden = false
      @category.save
      redirect_to :back
    end

    def hide
      @category = Category.find(params[:id])
      @category.is_hidden = true
      @category.save
      redirect_to :back
    end

    def up
      @category = Category.find(params[:id])
      @categoryX = Category.find_by(:sort => @category.sort - 1)
      @category.sort -= 1

      # 排序数字必须大于 0 #
      if @category.sort > 0
        @category.save
      end

      # 如果有比当前排序小一个数字的数据时，将该数据排序 +1（排序位置交换） #
      if @categoryX.present?
        @categoryX.sort += 1
        @categoryX.save
      end

      redirect_to :back
    end

    def down
      @category = Category.find(params[:id])
      @categoryX = Category.find_by(:sort => @category.sort + 1)
      @category.sort += 1
      @category.save

      # 如果有比当前排序大一个数字的数据时，将该数据排序 -1（排序位置交换） #
      if @categoryX.present?
        @categoryX.sort -= 1
        @categoryX.save
      end

      redirect_to :back
    end

  private

    def category_params
      params.require(:category).permit(:name,:icon,:is_hidden)
    end

end
