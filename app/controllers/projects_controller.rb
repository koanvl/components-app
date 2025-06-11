class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [ :show, :edit, :update, :destroy ]
  before_action :ensure_client!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :ensure_project_owner!, only: [ :edit, :update, :destroy ]

  def index
    projects = Project.includes(:client, :project_proposals).recent

    # Фильтры
    projects = projects.by_category(params[:category]) if params[:category].present?
    projects = projects.where(status: params[:status]) if params[:status].present?

    if params[:budget_min].present? && params[:budget_max].present?
      projects = projects.by_budget_range(params[:budget_min], params[:budget_max])
    end

    @projects = projects
    @categories = Project.distinct.pluck(:category).compact.sort
  end

  def show
    @project_proposal = current_user&.freelancer? ?
      @project.project_proposals.find_by(freelancer: current_user) : nil
    @proposals = @project.project_proposals.includes(:freelancer).recent if can_view_proposals?
  end

  def new
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build(project_params)
    @project.status = :open

    if @project.save
      redirect_to @project, notice: "Project was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project was successfully deleted."
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def ensure_client!
    redirect_to root_path, alert: "Access denied." unless current_user&.client?
  end

  def ensure_project_owner!
    redirect_to root_path, alert: "Access denied." unless @project.client == current_user
  end

  def can_view_proposals?
    current_user == @project.client
  end

  def project_params
    params.require(:project).permit(:title, :description, :budget_min, :budget_max,
                                   :deadline, :category, :skills, :status)
  end
end
