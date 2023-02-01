class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :helpfuls, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_secure_password
  before_save :email_downcase
  validates :username, presence: true, length: {maximum: 50 }
  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :profile, length: {maximum: 200}
  attachment :profile_image
  
  def already_favorited?(post)
    self.favorites.exists?(post_id: post.id)
  end

  # def already_helpful?(question)
  #   self.helpfuls.exists?(question_id: question.id)
  # end
  
    private
    def email_downcase
      self.email = email.downcase
    end
    
  
end