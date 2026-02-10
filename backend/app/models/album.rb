class Album < ApplicationRecord
  self.primary_key = "album_id"
  validates :title, presence: true
  validates :status, inclusion: {in: [true, false]}
  validates :title, uniqueness: {
    scope: :user_id,
    message: "Album\'s title must not be duplicated!"
  }, strict: true

  has_many :photos, -> {order(upload_at: :desc)}, foreign_key: "album_id", dependent: :nullify
  belongs_to :user, -> {select(:uid, :fname, :lname, :email)}
  has_many :public_photos, -> {where(status: true)}, class_name: "Photo"

  scope :public_with_pagination, -> (limit, offset) {
    where(status: true).order(public_at: :desc).limit(limit).offset(offset)
  }

  scope :all_with_pagination, -> (limit, offset) {
    order(updated_at: :desc).limit(limit).offset(offset)
  }

  accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: :all_blank

  before_validation :assign_user_to_photos

  private

  def assign_user_to_photos
    # Lặp qua các photo (cả mới và cũ)
    photos.each do |photo|
      # Gán user_id của album cho photo nếu photo chưa có user
      photo.user ||= self.user 
    end
  end
end