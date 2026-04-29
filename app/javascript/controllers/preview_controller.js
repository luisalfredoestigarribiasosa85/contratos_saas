import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["field", "output"]
  static values = { body: String }

  connect() {
    if (this.hasOutputTarget) {
      this.update()
    }
  }

  update() {
    if (!this.hasOutputTarget || !this.hasFieldTarget) return

    let content = this.bodyValue
    this.fieldTargets.forEach((field) => {
      const name = field.name.match(/\[(\w+)\]/)?.[1]
      if (name) {
        const regex = new RegExp(`\\{\\{${name}\\}\\}`, "g")
        content = content.replace(regex, field.value || `{{${name}}}`)
      }
    })
    this.outputTarget.textContent = content
  }
}
