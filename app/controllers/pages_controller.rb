class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @stats = {
      total_projects: Project.count,
      active_projects: Project.where(status: [ :open, :in_progress ]).count,
      total_freelancers: User.freelancer.count,
      total_clients: User.client.count,
      completed_projects: Project.completed.count
    }

    @recent_projects = Project.includes(:client)
                             .where(status: :open)
                             .recent
                             .limit(6)

    @featured_freelancers = User.freelancer
                               .joins(:portfolios)
                               .includes(:portfolios, avatar_attachment: :blob)
                               .distinct
                               .limit(8)
  end
end
