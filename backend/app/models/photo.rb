class Photo < ApplicationRecord
  self.primary_key = "photo_id"
  validates :title, presence: true
  validates :status, inclusion: {in: [true, false]}

  belongs_to :user
  belongs_to :album, foreign_key: "album_id", optional: true
end
