class Following < ApplicationRecord
  self.primary_key = [:follower_id, :following_id]

  validates :follower_id, uniqueness: { scope: :following_id }

  before_create :set_timestamps
  before_save :set_timestamps
  after_initialize :set_timestamps

  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"

  private
    def set_timestamps
      current_time = Time.current
      self.created_at ||= current_time
      self.updated_at ||= current_time
    end
end
