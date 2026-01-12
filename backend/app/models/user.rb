class User < ApplicationRecord
  self.primary_key = :uid
  enum :role, [:user, :admin]
  scope :created_before, ->(time) { where("created_at < ?", time) }
end