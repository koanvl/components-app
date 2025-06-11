class Portfolio < ApplicationRecord
  belongs_to :user

  # Active Storage attachments for portfolio images
  has_many_attached :images

  # Validations
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 2000 }
  validates :project_url, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid URL" }, allow_blank: true
  validates :technologies, presence: true, length: { maximum: 500 }
  validates :user, presence: true

  # Scopes
  scope :recent, -> { order(created_at: :desc) }
  scope :for_freelancer, ->(user) { where(user: user) if user&.freelancer? }

  # Helper methods
  def technology_list
    technologies.split(",").map(&:strip)
  end

  def technology_list=(list)
    self.technologies = Array(list).join(", ")
  end

  def has_images?
    images.attached?
  end

  def primary_image
    images.first if has_images?
  end
end
