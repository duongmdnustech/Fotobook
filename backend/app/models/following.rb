class Following < ApplicationRecord
  self.primary_key = [:follower_id, :following_id]
  belong_to :follower, class_name: "User"
  belong_to :following, class_name: "User"
end
