class User < ApplicationRecord
  self.primary_key = "uid"

  validates :fname, presence: true, format: {with: /\A[A-Za-zÀ-ỹ]+\z/, message: "Invalid Name"}
  validates :lname, presence: true, format: {with: /\A[A-Za-zÀ-ỹ]+\z/, message: "Invalid Name"}
  validates :email, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP, message: "Invalid Email"}
  validates :role, inclusion: {in: ["user", "admin"]}
  validates :password, format: {with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}\z/, message:"Password must have at least 8 characters, contains at least 1 downcase alphabet, 1 uppercase alphabet, 1 number and 1 special character"}

  before_save :password_hashing

  after_validation -> (user) {
    if user.errors.any?
      user.errors.each do |e|
        puts e.message        
      end
    end
  }

  private
    def password_hashing
      self.password = BCrypt::Password.create(self.password)
      Rails.logger.info("> Password has been hashed!")
    end

  enum :role, {
    user: "user",
    admin: "admin"
  }

  has_many :albums, -> {includes :photos}, dependent: :destroy
  has_many :photos, -> {order(public_at: :desc)}, dependent: :destroy
  has_many :public_albums, -> {where(status: true).order(public_at: :desc).limit(6)}, class_name: "Album"
  has_many :public_photos, -> {where(status: true).order(public_at: :desc).limit(6)}, class_name: "Photo"


  # Following other users
  has_many :active_followings, class_name: "Following", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, -> {select(:uid, :lname, :fname)}, class_name: "User", through: :active_followings, source: :following

  # Followed by other users
  has_many  :passive_followers, class_name: "Following", foreign_key: "following_id", dependent: :destroy
  has_many  :followers, -> {select(:uid, :lname, :fname)}, class_name: "User", through: :passive_followers, source: :follower
  
  scope :public_details, -> {select(:uid, :fname, :lname, :email)}
  
  def self.user_with_public_details uid 
    select(:uid, :fname, :lname, :email).find(uid)
  end
end