module ProjectsHelper
  def project_status_label(project)
    content_tag(:div, project.status_human, class: "label label-#{project_status_type(project)}")
  end

  def project_status_type(project)
    if project.wait_comments?
      'default'
    elsif project.with_comments?
      'warning'
    elsif project.accepted?
      'success'
    end
  end
end
