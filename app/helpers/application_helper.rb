module ApplicationHelper
  def budget_range(project)
    if project.budget_min.present? && project.budget_max.present?
      "$#{number_with_delimiter(project.budget_min)} - $#{number_with_delimiter(project.budget_max)}"
    elsif project.budget_min.present?
      "$#{number_with_delimiter(project.budget_min)}+"
    elsif project.budget_max.present?
      "Up to $#{number_with_delimiter(project.budget_max)}"
    else
      "Budget TBD"
    end
  end

  def user_initials(user)
    if user.first_name.present? && user.last_name.present?
      "#{user.first_name.first}#{user.last_name.first}".upcase
    elsif user.first_name.present?
      user.first_name.first(2).upcase
    elsif user.email.present?
      user.email.first(2).upcase
    else
      "U"
    end
  end

  def display_name(user)
    if user.first_name.present? && user.last_name.present?
      "#{user.first_name} #{user.last_name}"
    elsif user.first_name.present?
      user.first_name
    else
      user.email.split("@").first.humanize
    end
  end

  def project_status_badge(status)
    case status
    when "open"
      content_tag :span, "Open", class: "px-2 py-1 bg-green-100 text-green-800 text-xs rounded-full"
    when "in_progress"
      content_tag :span, "In Progress", class: "px-2 py-1 bg-blue-100 text-blue-800 text-xs rounded-full"
    when "completed"
      content_tag :span, "Completed", class: "px-2 py-1 bg-gray-100 text-gray-800 text-xs rounded-full"
    when "cancelled"
      content_tag :span, "Cancelled", class: "px-2 py-1 bg-red-100 text-red-800 text-xs rounded-full"
    else
      content_tag :span, status.humanize, class: "px-2 py-1 bg-gray-100 text-gray-800 text-xs rounded-full"
    end
  end
end
