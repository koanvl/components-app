import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "button"]

  connect() {
    this.boundHandleClickOutside = this.handleClickOutside.bind(this)
  }

  disconnect() {
    document.removeEventListener("click", this.boundHandleClickOutside)
  }

  toggle() {
    if (this.menuTarget.classList.contains("hidden")) {
      this.show()
    } else {
      this.hide()
    }
  }

  show() {
    this.menuTarget.classList.remove("hidden")
    this.buttonTarget.setAttribute("aria-expanded", "true")
    document.addEventListener("click", this.boundHandleClickOutside)
  }

  hide() {
    this.menuTarget.classList.add("hidden")
    this.buttonTarget.setAttribute("aria-expanded", "false")
    document.removeEventListener("click", this.boundHandleClickOutside)
  }

  handleClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.hide()
    }
  }
} 