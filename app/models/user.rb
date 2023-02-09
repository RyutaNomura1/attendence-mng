class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :helpfuls, dependent: :destroy
  has_many :answers, dependent: :destroy
  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  
  
  attr_accessor :remember_token
  
  has_secure_password
  # パスワードupdate時にはバリデーションがかからないため追加
  validate(on: :update) do |record|
    record.errors.add(:password, :blank) unless record.password_digest.present?
  end
  validates :password, presence: true
  validates_length_of :password, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED, on: :update
  validates_confirmation_of :password, allow_blank: true, on: :update
  
  before_save :email_downcase
  validates :username, presence: true, length: {maximum: 50 }
  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :profile, length: {maximum: 200}
  attachment :profile_image

  # 文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  #トークンをダイジェスト化してDBに保存する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))  
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
    # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # 既にいいねしているか確認
  def already_favorited?(post)
    self.favorites.exists?(post_id: post.id)
  end

  # 既に役立つを押しているか確認
  def already_helpful?(answer)
    self.helpfuls.exists?(answer_id: answer.id)
  end
  
    private
    def email_downcase
      self.email = email.downcase
    end
    
  
end