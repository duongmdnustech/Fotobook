class Album < ApplicationRecord
  self.primary_key = "album_id"
  has_many :photos
end
