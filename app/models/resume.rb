class Resume < ApplicationRecord
  validates :content, presence: { message: "请填写简历描述" }
  validates :attachment, presence: { message: "请选择简历文档" }

  mount_uploader :attachment, AttachmentUploader

  belongs_to :job
  belongs_to :user

  scope :recent, -> { order('created_at DESC') }
end
