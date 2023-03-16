import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2'

// Connects to data-controller="notifications"
export default class extends Controller {

  connect() {
    console.log("hello");
  }

  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`)
    return element.getAttribute("content")
  }

  confirm(event){
    event.preventDefault()
    const link = event.currentTarget
    const url = link.href
    const message = link.dataset.turboConfirm
    console.log(link.dataset.turboConfirm);
    Swal.fire({
      title: 'Are you sure?',
      text: message,
      icon: 'question',
      showCancelButton: true,
      confirmButtonColor: '#ef8535',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
      let token = this.getMetaValue("csrf-token");
        if (result.isConfirmed) {
        fetch(url, {method: link.dataset.turboMethod, headers:{"X-CSRF-Token": token}})
          .then(()=>{
            Swal.fire(
              'Deleted!',
              '',
              'success'
            )
            .then((result)=>{if(result.isConfirmed){location.reload()}})
          })
      }
    })
  }

  pop_up(event){
    const link = event.currentTarget
    Swal.fire({
      position: 'center',
      icon: 'success',
      title: link.dataset.message,
      showConfirmButton: false,
      timer: 3000
    })
  }
}
