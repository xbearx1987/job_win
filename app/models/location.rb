class Location < ApplicationRecord
  validates :name, presence: { message: "请输入工作地点" }

  has_many :jobs

  scope :published, -> { where(is_hidden: false) }
  scope :sortA, -> { order('sort ASC') }
  scope :sortD, -> { order('sort DESC') }
end
