class ProjectProposalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [ :create ]
  before_action :set_project_proposal, only: [ :show, :update, :destroy ]
  before_action :ensure_freelancer!, only: [ :create ]
  before_action :ensure_proposal_owner_or_client!, only: [ :show, :update, :destroy ]

  def create
    @project_proposal = @project.project_proposals.build(project_proposal_params)
    @project_proposal.freelancer = current_user
    @project_proposal.status = :pending

    if @project_proposal.save
      redirect_to @project, notice: "Your proposal has been submitted successfully!"
    else
      redirect_to @project, alert: @project_proposal.errors.full_messages.join(", ")
    end
  end

  def show
    @project = @project_proposal.project
  end

  def update
    case params[:action_type]
    when "accept"
      if @project_proposal.can_be_accepted? && @project_proposal.project.client == current_user
        @project_proposal.update!(status: :accepted)
        @project_proposal.project.update!(status: :in_progress)
        redirect_to @project_proposal.project, notice: "Proposal accepted! Project is now in progress."
      else
        redirect_to @project_proposal.project, alert: "Cannot accept this proposal."
      end
    when "reject"
      if @project_proposal.pending? && @project_proposal.project.client == current_user
        @project_proposal.update!(status: :rejected)
        redirect_to @project_proposal.project, notice: "Proposal rejected."
      else
        redirect_to @project_proposal.project, alert: "Cannot reject this proposal."
      end
    when "withdraw"
      if @project_proposal.can_be_withdrawn? && @project_proposal.freelancer == current_user
        @project_proposal.update!(status: :withdrawn)
        redirect_to @project_proposal.project, notice: "Proposal withdrawn."
      else
        redirect_to @project_proposal.project, alert: "Cannot withdraw this proposal."
      end
    else
      redirect_to @project_proposal.project, alert: "Invalid action."
    end
  end

  def destroy
    project = @project_proposal.project
    if @project_proposal.freelancer == current_user && @project_proposal.can_be_withdrawn?
      @project_proposal.destroy
      redirect_to project, notice: "Proposal deleted."
    else
      redirect_to project, alert: "Cannot delete this proposal."
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_project_proposal
    @project_proposal = ProjectProposal.find(params[:id])
  end

  def ensure_freelancer!
    redirect_to root_path, alert: "Access denied." unless current_user&.freelancer?
  end

  def ensure_proposal_owner_or_client!
    unless @project_proposal.freelancer == current_user || @project_proposal.project.client == current_user
      redirect_to root_path, alert: "Access denied."
    end
  end

  def project_proposal_params
    params.require(:project_proposal).permit(:proposal_text, :budget, :timeline)
  end
end
