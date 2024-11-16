import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="logs--index"
export default class extends Controller {
  static targets = ["fileInput", "form"]

  initialize() {
    this.events = ["dragover", "dragenter", "dragleave", "drop"]
    this.eventHandlers = {}
  }

  connect() {
    this.attachEventListeners();
  }

  attachEventListeners() {
    this.events.forEach(event => {
      const handler = this[event].bind(this);
      this.eventHandlers[event] = handler;
      this.element.addEventListener(event, handler)
    })
  }

  dragover(event) {
    event.preventDefault()
  }

  dragenter(event) {
    event.preventDefault()
  }

  dragleave(event) {
    event.preventDefault()
  }

  drop(event) {
    event.preventDefault()
    this.fileInputTarget.files = event.dataTransfer.files
    this.formTarget.submit()
  }

  disconnect() {
    this.events.forEach(event => {
      const handler = this.eventHandlers[event];
      if (handler) this.element.removeEventListener(event, handler);
    });
  }
}
