import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="home"
export default class extends Controller {
  static targets = ["searchInput"]
  
  connect() {
  }

  switch_page(event) {
    event.currentTarget.classList.remove("disable")
    Array.from(document.getElementsByClassName("page")).forEach(element => {
      if (element.id === event.currentTarget.id)
        element.classList.remove("disable")
      else if (!Array.from(element.classList).includes("disable"))
        element.classList.add("disable");
    });
  }


  onSearchChange(event) {
    clearTimeout(this.timeout)

    this.timeout = setTimeout(() => {
      const query = event.target.value.trim()
      const url = new URL(window.location.href)

      if (query.length > 0) {
        url.searchParams.set("query", query)
        url.searchParams.delete("page")
      } else {
        url.searchParams.delete("query")
      }

      Turbo.visit(url.toString(), { action: "replace" })
    }, 300)
  }
}
