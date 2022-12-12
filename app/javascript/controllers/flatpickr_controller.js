import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
// Import the rangePlugin from the flatpickr library
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = [ "startTime", "endTime"]

  connect() {
    console.log("date connected")
    const today = new Date()
    const tomorrow = new Date(today)
    tomorrow.setDate(tomorrow.getDate() + 1)
    const totalPrice = document.querySelector("#totalprice");
    const priceStr = document.querySelector("#price").innerText;
    const price = priceStr / 1;
    flatpickr(this.startTimeTarget, {
              // enableTime: true,
              altInput: true,
              altFormat: "F j, Y",
              dateFormat: "Y-m-d",
              minDate: tomorrow,
              // Provide an id for the plugin to work
              plugins: [new rangePlugin({ input: "#end_time"})],
              onChange: function(selectedDates) {
                console.log();
                if(selectedDates.length === 2){
                  let timeDiff = Math.abs(selectedDates[1].getDate() - selectedDates[0].getDate());
                  totalPrice.innerHTML = `${Math.round(timeDiff * price)}`
                }
            }
            })
    flatpickr(this.endTimeTarget, {})
  }
}
