import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["list", "template"]

  add(event) {
    event.preventDefault()

    // 1. Lấy nội dung HTML từ thẻ <template>
    let content = this.templateTarget.innerHTML

    // 2. Tạo một ID duy nhất (dùng thời gian hiện tại)
    let uniqueId = new Date().getTime()

    // 3. Thay thế từ khóa "NEW_RECORD" bằng ID mới
    // Regex này sẽ thay thế tất cả các chỗ có name="album[photos_attributes][NEW_RECORD]..."
    content = content.replace(/NEW_RECORD/g, uniqueId)

    // 4. Chèn vào cuối danh sách
    this.listTarget.insertAdjacentHTML('beforeend', content)
  }

  remove(event) {
    event.preventDefault()

    // 1. Tìm thẻ cha gần nhất có class "album-photo-item" (định nghĩa ở dưới)
    const wrapper = event.target.closest(".album-photo-item")
    
    // 2. Nếu tìm thấy thì xóa nó đi
    if (wrapper) {
      wrapper.remove()
    }
  }
}