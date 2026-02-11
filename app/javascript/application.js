// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
//import "popper"
import "bootstrap"
import "components"
// import { Toast } from "bootstrap" // Import trực tiếp class Toast

// const showToasts = () => {
//   const toastElList = document.querySelectorAll('.toast:not(.show)') // Chỉ tìm các toast chưa hiển thị
//   toastElList.forEach(toastEl => {
//     const toast = new Toast(toastEl)
//     toast.show()
    
//     // Tùy chọn: Tự động xóa khỏi DOM sau khi ẩn để tránh làm rác trang
//     toastEl.addEventListener('hidden.bs.toast', () => {
//       toastEl.remove()
//     })
//   })
// }

// // Lắng nghe các sự kiện của Turbo
// document.addEventListener("turbo:load", showToasts)
// document.addEventListener("turbo:render", showToasts)
// document.addEventListener("turbo:frame-render", showToasts)