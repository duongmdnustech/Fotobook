class Photo < ApplicationRecord
  self.primary_key = "photo_id"
  validates :title, presence: true
  validates :status, inclusion: {in: [true, false]}

  belongs_to :user
  belongs_to :album, foreign_key: "album_id", optional: true

  validate :user_matches_album

  def user_matches_album
    if !album
      return
    end

    if user_id != album.user_id
      errors.add(:user_id, "must match album owner #{Photo.count}")
    end
  end
end
