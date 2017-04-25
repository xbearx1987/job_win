class Admin::CategorysController < ApplicationController
layout "admin"

  def index
    @categorys = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categorys_path, notice: "职位类型新增成功。"
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
      redirect_to admin_categorys_path, notice: "职位类型修改成功。"
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

private

  def category_params
    params.require(:category).permit(:name,:icon,:is_hidden)
  end
end
