module ProjectsHelper
  def project_status_label(project)
    content_tag(:div, project.status_human, class: "label #{project_status_label_type(project)}")
  end

  def project_status_label_type(project)
    if project.wait_comments?
      'label-default'
    elsif project.with_comments?
      'label-warning'
    elsif project.accepted?
      'label-success'
    end
  end
end
