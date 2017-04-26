module JobsHelper
  # 判断显示/隐藏icon #
  def render_job_status(job)
    if job.is_hidden
      "fa fa-lock"
    else
      "fa fa-globe"
    end
  end

  # 薪水区间 #
  def render_job_wage(job)
    "#{job.wage_lower_bound} k ~ #{job.wage_upper_bound} k"
  end

  # 判断是否投递过简历icon #
  def render_job_resumes(job)
    if job.resumes.count > 0
      "fa fa-envelope-open-o"
    else
      "fa fa-envelope-o"
    end
  end

  # 判断是否有人收藏icon #
  def render_job_collections(job)
    if job.collections.count > 0
      "fa fa-heart"
    else
      "fa fa-heart-o"
    end
  end

end
