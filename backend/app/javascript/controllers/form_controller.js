// app/javascript/controllers/image_preview_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "placeholder", "image", "container", "removeInput", "removeButton", "undoButton", "avatar"]

  preview() {
    const input = this.inputTarget
    const file = input.files[0]
    
    if (file) {
      // TRƯỜNG HỢP 1: Có file mới được chọn -> Hiển thị file đó
      const reader = new FileReader()
      reader.onload = (e) => this.showImage(e.target.result)
      reader.readAsDataURL(file)

    } else {
      // TRƯỜNG HỢP 2: User bấm Cancel hoặc bỏ chọn file
      // Kiểm tra xem có ảnh gốc (từ DB) để quay về không
      const originalUrl = this.imageTarget.dataset.originalUrl

      if (originalUrl && originalUrl.length > 0) {
        // Nếu có ảnh gốc -> Hiển thị lại ảnh gốc
        this.showImage(originalUrl)
      } else {
        // Nếu không có ảnh gốc nào -> Reset về trạng thái trống (hiện dấu +)
        this.showPlaceholder()
      }
    }
  }

  // Hàm phụ trợ để hiển thị ảnh (giúp code gọn hơn)
  showImage(src) {
    this.imageTarget.src = src
    this.imageTarget.classList.remove("d-none")
    this.placeholderTarget.classList.add("d-none")
    
    // Xử lý style cho container (nếu bạn có target container)
    if (this.hasContainerTarget) {
        this.containerTarget.classList.add("border-0", "bg-transparent")
        this.containerTarget.style.minHeight = "auto"
    }
  }

  // Hàm phụ trợ để hiện Placeholder
  showPlaceholder() {
    this.imageTarget.classList.add("d-none")
    this.imageTarget.src = "" // Xóa src để tránh lỗi
    this.placeholderTarget.classList.remove("d-none")
    
    if (this.hasContainerTarget) {
        this.containerTarget.classList.remove("border-0", "bg-transparent")
        this.containerTarget.style.minHeight = "200px" // Hoặc chiều cao mặc định của bạn
    }
  }

  previewAvatar() {
    const input = this.inputTarget
    const file = input.files[0]
    
    if (file) {
      const reader = new FileReader()
      reader.onload = (e) => {
        this.avatarTarget.src = e.target.result
        // Có file -> Hiện ảnh, Ẩn placeholder
        this.showImageState()
      }
      reader.readAsDataURL(file)
      
      this.toggleButtons(true) 
      if (this.hasRemoveInputTarget) this.removeInputTarget.checked = false
    }
  }

  remove(event) {
    event.preventDefault()

    if (this.hasRemoveInputTarget) this.removeInputTarget.checked = true
    this.inputTarget.value = ""

    // Xóa -> Ẩn ảnh, Hiện placeholder
    this.showPlaceholderState()
    
    this.toggleButtons(false)
  }

  undo(event) {
    event.preventDefault()
    if (this.hasRemoveInputTarget) this.removeInputTarget.checked = false

    const originalUrl = this.avatarTarget.dataset.originalUrl

    // Nếu lúc đầu có ảnh (originalUrl không rỗng) -> Hiện lại ảnh cũ
    if (originalUrl && originalUrl.trim() !== "") {
      this.avatarTarget.src = originalUrl
      this.showImageState()
    } else {
      // Nếu lúc đầu chưa có ảnh -> Vẫn hiện placeholder
      this.showPlaceholderState()
    }

    this.toggleButtons(true)
  }

  // --- Helpers để code gọn hơn ---

  showImageState() {
    this.avatarTarget.classList.remove("d-none")
    this.placeholderTarget.classList.add("d-none")
  }

  showPlaceholderState() {
    this.avatarTarget.classList.add("d-none")
    this.placeholderTarget.classList.remove("d-none")
  }

  toggleButtons(showRemove) {
    if (this.hasRemoveButtonTarget) {
      this.removeButtonTarget.classList.toggle("d-none", !showRemove)
    }
    if (this.hasUndoButtonTarget) {
      this.undoButtonTarget.classList.toggle("d-none", showRemove)
    }
  }
}