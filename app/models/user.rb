# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Role system
  enum role: { client: 0, freelancer: 1 }

  # Associations
  has_one_attached :avatar
  has_many :portfolios, dependent: :destroy

  # Validations
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :role, presence: true
  validates :professional_title, length: { maximum: 100 }
  validates :company_name, length: { maximum: 100 }
  validates :bio, length: { maximum: 1000 }

  # Callbacks
  after_initialize :set_default_role, if: :new_record?

  # Helper methods
  def display_name
    "#{first_name} #{last_name}".strip
  end

  def initials
    "#{first_name&.first}#{last_name&.first}".upcase
  end

  def profile_complete?
    required_fields = [ first_name, last_name, role ]
    required_fields << professional_title if freelancer?
    required_fields.all?(&:present?)
  end

  def profile_completion_percentage
    total_fields = freelancer? ? 6 : 5
    completed_fields = 0

    completed_fields += 1 if first_name.present?
    completed_fields += 1 if last_name.present?
    completed_fields += 1 if role.present?
    completed_fields += 1 if avatar.attached?
    completed_fields += 1 if bio.present?
    completed_fields += 1 if freelancer? && professional_title.present?

    (completed_fields.to_f / total_fields * 100).round
  end

  private

  def set_default_role
    self.role ||= :client
  end
end
