class Task < ApplicationRecord
  class << self
    def ransackable_attributes(auth_object = nil)
      %w[name created_at deadline]
    end

    def ransackable_associations(auth_object = nil)
      []
    end
  end

  before_validation :set_nameless_name
  validates :name, presence: true
  validates :name, length: { maximum: 30 }
  validate :validate_name_not_including_comma

  belongs_to :user
  scope :recent, -> { order(created_at: :desc) }

  private

  def set_nameless_name
    self.name = '名前無し' if name.blank?
  end

  def validate_name_not_including_comma
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end
end
