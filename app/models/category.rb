class Category < ApplicationRecord
  validates :name, presence: { message: "请输入类型名称" }
  validates :icon, presence: { message: "请输入ICON代码" }
end
