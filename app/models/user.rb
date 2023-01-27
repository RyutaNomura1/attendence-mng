class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_secure_password
  before_save :email_downcase
  validates :username, presence: true, length: {maximum: 50 }
  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :profile, length: {maximum: 200}
  attachment :profile_image
    private
    def email_downcase
      self.email = email.downcase
    end
end
