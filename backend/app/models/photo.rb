class Photo < ApplicationRecord
  self.primary_key = "photo_id"
  belongs_to :user
  belongs_to :album
end
