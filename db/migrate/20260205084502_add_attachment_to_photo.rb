class AddAttachmentToPhoto < ActiveRecord::Migration[8.1]
  def change
    change_table :photos do |t|
      t.string :image, default: "", null: false
    end
  end
end
