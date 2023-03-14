import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="review"
export default class extends Controller {
  static targets = [ "form", "submit" ];

  connect() {
    console.log("Connecting to data-controller")
  }

  toggleForm() {
    this.formTarget.classList.toggle("d-none");
  }
}
