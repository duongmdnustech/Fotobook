class User < ApplicationRecord
  self.primary_key = "uid"
  enum :role, {
    user: "user",
    admin: "admin"
  }
  has_many :albums, -> {order(public_at: :desc)}, dependent: :destroy
  has_many :photos, -> {order(public_at: :desc)}, dependent: :destroy
  has_many :public_albums, -> {where(status: true).order(public_at: :desc).limit(6)}, class_name: "Album"
  has_many :public_photos, -> {where(status: true).order(public_at: :desc).limit(6)}, class_name: "Photo"

  # Following other users
  has_many :active_followings, class_name: "Following", foreign_key: "following_id", dependent: :destroy
  has_many :followings, -> {select(:uid, :lname, :fname)}, class_name: "User", through: :active_followings, source: :following

  # Followed by other users
  has_many  :passive_followers, class_name: "Following", foreign_key: "follower_id", dependent: :destroy
  has_many  :followers, -> {select(:uid, :lname, :fname)}, class_name: "User", through: :passive_followers, source: :follower
end