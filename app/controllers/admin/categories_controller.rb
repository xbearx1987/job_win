class Admin::CategoriesController < ApplicationController
  layout "admin"

    def index
      @categorys = Category.all.order("sort")
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)
      @sort = Category.last.sort + 1
      @category.sort = @sort

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
      @category.sort -= 1
      @category.save
      redirect_to :back
    end

    def down
      @category = Category.find(params[:id])
      @category.sort += 1
      @category.save
      redirect_to :back
    end

  private

    def category_params
      params.require(:category).permit(:name,:icon,:is_hidden)
    end
end
