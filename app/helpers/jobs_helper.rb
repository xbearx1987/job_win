module JobsHelper
  def render_job_status(job)
    if job.is_hidden
      "glyphicon glyphicon-lock"
    else
      "glyphicon glyphicon-globe"
    end
  end
end
