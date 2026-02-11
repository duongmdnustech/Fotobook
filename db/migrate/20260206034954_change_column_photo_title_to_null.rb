class ChangeColumnPhotoTitleToNull < ActiveRecord::Migration[8.1]
  def up 
    change_column_null :photos, :title, true
  end

  def down
    change_column_null :photos, :title, false
  end
end
