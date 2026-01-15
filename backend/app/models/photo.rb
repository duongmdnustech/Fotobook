class Photo < ApplicationRecord
  self.primary_key = "photo_id"
  belong_to :user
  belong_to :album
end
