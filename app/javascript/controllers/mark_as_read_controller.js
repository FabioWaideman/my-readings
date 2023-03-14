import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mark-as-read"
export default class extends Controller {
  static values = {id: Number}
  static targets = ["book"]

  connect() {
    console.log(this.idValues);
  }

  markAsRead(event){
    event.preventDefault()
    let id = event.currentTarget.dataset.markAsReadIdValue
    console.log(id);
   fetch(`/bookmarks/${id}`, {
      headers: { "Accept": "text/plain" }, // formato da requisição
      method: 'PATCH', // método da requisição (update = PATCH)
      body: {} // informações do formulário
    })
      // .then(response => response.text())
      // .then((data) => {
      //   // Substituir o card do filme com a info que o Rails mandou
      //   // O this.element é o elemento que contém a propriedade do data-controller
      //   this.element.outerHTML = data
      // })
  }

  // #getMetaValue(name) {
  //   const element = document.head.querySelector(`meta[name="${name}"]`)
  //   return element.getAttribute("content")
  // }
}
