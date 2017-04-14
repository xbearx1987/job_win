class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :jobs
  has_many :resumes
  has_many :collection
  has_many :collected_jobs, :through => :collection, :source => :job

  def admin?
    is_admin
  end

  def is_member_of?(job)
    collected_jobs.include?(job)
  end

  def add_collection!(job)
    collected_jobs << job
  end

  def remove_collection!(job)
    collected_jobs.delete(job)
  end
end
