class ProjectProposal < ApplicationRecord
  belongs_to :project
  belongs_to :freelancer, class_name: "User"

  # Статусы отклика
  enum status: {
    pending: 0,     # Ожидает рассмотрения
    accepted: 1,    # Принят
    rejected: 2,    # Отклонен
    withdrawn: 3    # Отозван фрилансером
  }

  # Валидации
  validates :proposal_text, presence: true, length: { minimum: 50, maximum: 1000 }
  validates :budget, presence: true, numericality: { greater_than: 0 }
  validates :timeline, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true
  validates :freelancer_id, uniqueness: { scope: :project_id, message: "You can only submit one proposal per project" }

  validate :project_must_be_open
  validate :budget_within_project_range
  validate :freelancer_cannot_apply_to_own_project

  # Scopes
  scope :recent, -> { order(created_at: :desc) }
  scope :for_project, ->(project) { where(project: project) }
  scope :by_freelancer, ->(freelancer) { where(freelancer: freelancer) }

  # Helper methods
  def timeline_text
    case timeline
    when 1..7
      "#{timeline} day#{'s' if timeline > 1}"
    when 8..30
      weeks = (timeline / 7.0).ceil
      "#{weeks} week#{'s' if weeks > 1}"
    else
      months = (timeline / 30.0).ceil
      "#{months} month#{'s' if months > 1}"
    end
  end

  def can_be_accepted?
    pending? && project.open?
  end

  def can_be_withdrawn?
    pending?
  end

  private

  def project_must_be_open
    return unless project.present?

    errors.add(:project, "must be open for proposals") unless project.open?
  end

  def budget_within_project_range
    return unless budget.present? && project.present?

    if budget < project.budget_min || budget > project.budget_max
      errors.add(:budget, "must be within project budget range (#{project.budget_range})")
    end
  end

  def freelancer_cannot_apply_to_own_project
    return unless freelancer.present? && project.present?

    errors.add(:freelancer, "cannot apply to own project") if freelancer == project.client
  end
end
