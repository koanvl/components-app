class Project < ApplicationRecord
  belongs_to :client, class_name: "User"
  has_many :project_proposals, dependent: :destroy
  has_many :freelancers, through: :project_proposals, source: :freelancer

  # Статусы проекта
  enum status: {
    open: 0,           # Открыт для откликов
    in_progress: 1,    # В работе
    completed: 2,      # Завершен
    cancelled: 3       # Отменен
  }

  # Валидации
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 2000 }
  validates :budget_min, presence: true, numericality: { greater_than: 0 }
  validates :budget_max, presence: true, numericality: { greater_than: 0 }
  validates :deadline, presence: true
  validates :status, presence: true
  validates :category, presence: true, length: { maximum: 50 }
  validates :skills, presence: true, length: { maximum: 500 }

  validate :budget_max_greater_than_min
  validate :deadline_in_future

  # Scopes
  scope :recent, -> { order(created_at: :desc) }
  scope :by_category, ->(category) { where(category: category) if category.present? }
  scope :by_budget_range, ->(min, max) { where(budget_min: min..max) if min.present? && max.present? }

  # Helper methods
  def budget_range
    if budget_min.present? && budget_max.present?
      "$#{budget_min.to_i} - $#{budget_max.to_i}"
    elsif budget_min.present?
      "$#{budget_min.to_i}+"
    elsif budget_max.present?
      "Up to $#{budget_max.to_i}"
    else
      "Budget TBD"
    end
  end

  def skills_list
    skills.split(",").map(&:strip)
  end

  def skills_list=(list)
    self.skills = Array(list).join(", ")
  end

  def days_until_deadline
    return 0 if deadline.past?
    (deadline - Date.current).to_i
  end

  def proposals_count
    project_proposals.count
  end

  def can_apply?(user)
    user&.freelancer? && open? && client != user
  end

  private

  def budget_max_greater_than_min
    return unless budget_min.present? && budget_max.present?

    errors.add(:budget_max, "must be greater than or equal to minimum budget") if budget_max < budget_min
  end

  def deadline_in_future
    return unless deadline.present?

    errors.add(:deadline, "must be in the future") if deadline <= Date.current
  end
end
