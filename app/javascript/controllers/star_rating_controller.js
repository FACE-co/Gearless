import { Controller } from "@hotwired/stimulus"
import StarRating from "star-rating.js"

export default class extends Controller {
  connect() {
    console.log("star-rating connected")
    new StarRating(this.element)
  }
}
