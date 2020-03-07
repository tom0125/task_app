class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    # case_sensitiveオプションにfalseを指定することで、大文字小文字の差を無視するすることが可能
                    uniqueness: { case_sensitive: false }

  has_secure_password
  has_many :tasks
end
