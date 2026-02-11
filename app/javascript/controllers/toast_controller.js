import { Controller } from "@hotwired/stimulus"
import { Toast } from "bootstrap" // Bây giờ dòng này sẽ hoạt động ngon lành!

export default class extends Controller {
  connect() {
    this.toast = new Toast(this.element, {
      animation: true,
      autohide: true,
      delay: 5000
    })
    this.toast.show()
  }
}