class Album < ApplicationRecord
  self.primary_key = "album_id"
  has_many :photos, -> {where(status: true).order(public_at: :desc)}, dependent: :nullify
  belongs_to :user
end
