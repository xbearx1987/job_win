class Job < ApplicationRecord
  validates :name, presence: { message: "请填写职称" }
  validates :content, presence: { message: "请填写职位描述" }
  validates :company, presence: { message: "请填写公司名称" }
  validates :category, presence: { message: "请选择职位类型" }
  validates :location, presence: { message: "请选择工作地点" }
  validates :wage_lower_bound, presence: { message: "请填写最低薪水" }
  validates :wage_upper_bound, presence: { message: "请填写最高薪水" }
  validates :wage_lower_bound, numericality: { less_than: :wage_upper_bound, message: "薪水下限不能高于薪水上限" }
  validates :wage_upper_bound, numericality: { greater_than: 0, message: "最小薪水必须大于零" }
  validates :contact_mail, presence: { message: "请填写联系用的邮箱" }
  validates_format_of :contact_mail, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i , message: "请输入正确的邮箱格式"

  belongs_to :user
  has_many :resumes, dependent: :destroy
  has_many :collections, dependent: :destroy
  has_many :members, through: :collections, source: :user

  scope :recent, -> { order('created_at DESC') }
  scope :published, -> { where(is_hidden: false) }
  scope :random5, -> { limit(5).order("RANDOM()") }

  scope :wage1, -> { where('wage_lower_bound <= 5 or wage_upper_bound <= 5') }
  scope :wage2, -> { where('wage_lower_bound between 5 and 10 or wage_upper_bound between 5 and 10') }
  scope :wage3, -> { where('wage_lower_bound between 10 and 15 or wage_upper_bound between 10 and 15') }
  scope :wage4, -> { where('wage_lower_bound between 15 and 25 or wage_upper_bound between 15 and 25') }
  scope :wage5, -> { where('wage_lower_bound >= 25 or wage_upper_bound >= 25') }

end
