import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2'

// Connects to data-controller="reviews"
export default class extends Controller {
  // static values = { book: Number }
  //  static values = { book: String }
  // connect() {
  //   console.log(this.bookValue);
  // }
  connect() {
    // console.log(this.element);
    console.log("hello");
  }

  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`)
    return element.getAttribute("content")
  }

  create(event) {
    let token = this.getMetaValue("csrf-token");
    const book = this.element.dataset.reviewsBookValue
    // console.log(this.element.dataset.reviewsBookValue);

    Swal.fire({
      title: `Create a new review`,
      icon: '',
      html:
      `<form class="simple_form new_review" id="new_review" novalidate="novalidate" action="/books/${book}/reviews" accept-charset="UTF-8" method="post">
        <div class="mb-3 select required review_rating">
          <input type="hidden" name="authenticity_token" value="${token}" autocomplete="off">
          <label class="form-label select required" for="review_rating">Rating <abbr title="required">*</abbr></label>
          <select class="form-select select required" name="review[rating]" id="review_rating">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
          </select>
        </div>
        <div class="mb-3 text required review_content">
          <label class="form-label text required" for="review_content">Content <abbr title="required">*</abbr></label>
          <textarea class="form-control text required" name="review[content]" id="review_content"></textarea>
        </div>
        <input type="submit" name="commit" value="Create Review" class="mybutton" data-turbo="false" data-disable-with="Create Review">
      </form>`,
      showCloseButton: true,
      showCancelButton: false,
      showConfirmButton: false,
      focusConfirm: false,
      confirmButtonText:
        '',
      confirmButtonAriaLabel: 'Thumbs up, great!',
      cancelButtonText:
        '<i class="fa fa-thumbs-down"></i>',
      cancelButtonAriaLabel: 'Thumbs down'
    })
  }

  confirm(event){
    event.preventDefault()
    const link = event.currentTarget
    const url = link.href
    const message = `Your ${link.dataset.message} has been deleted.`
    // console.log(message);
    Swal.fire({
      title: 'Are you sure?',
      text: "You won't be able to revert this!",
      icon: 'question',
      showCancelButton: true,
      buttonsStyling: false,
      confirmButtonText: 'Yes, delete it!',
      customClass: {
        confirmButton: 'mybutton me-1',
        cancelButton: 'cancel-button ms-1'
      },
      confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
      let token = this.getMetaValue("csrf-token");
        if (result.isConfirmed) {
        fetch(url, {method: link.dataset.turboMethod, headers:{"X-CSRF-Token": token}})
          .then(()=>{
            Swal.fire({
              title: 'Deleted!',
              text: message,
              icon: 'success',
              customClass: {
                confirmButton: 'mybutton me-1'
              }
            })
            .then((result)=>{if(result.isConfirmed){location.reload()}})
          })
      }
    })
  }
}
