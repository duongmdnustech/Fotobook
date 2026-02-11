class AddIdConstraintToFollowings < ActiveRecord::Migration[8.1]
  def up
    # 1. Xóa khóa chính cũ (cột id) nếu có
    # (Nếu bảng bạn tạo id: false từ đầu thì bỏ dòng này)

    # 2. Thêm constraint Primary Key bằng SQL thuần
    execute "ALTER TABLE followings ADD PRIMARY KEY (follower_id, following_id);"
  end

  def down
    # Định nghĩa cách rollback nếu cần
    execute "ALTER TABLE followings DROP CONSTRAINT followings_pkey;"
  end
end
