class Resume < ApplicationRecord
  validates :content, :attachment, presence: true

  belongs_to :job
  belongs_to :user
end
