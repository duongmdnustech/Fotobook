class User < ApplicationRecord
  self.primary_key = "uid"
  enum :role, [:user, :admin]
  has_many :albums
  has_many :photos

  # Following other users
  has_many :active_followings, class_name: "Following", foreign_key: "following_id", dependent: :destroy
  has_many :folowings, through: :active_followings, source: :following

  # Followed by other users
  has_many  :passive_followers, class_name: "Following", foreign_key: "follower_id", dependent: :destroy
  has_many  :followers, through: :passive_followers, source: :follower
  scope :created_before, ->(time) { where("created_at < ?", time) }
end