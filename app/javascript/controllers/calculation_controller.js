import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["bill", "tip", "people", "tipAmount", "totalAmount"];

  connect() {
    console.log("connected");
  }

  handleFieldInput(event) {
    if (event && event.target) {
      const field = event.target;
      this.updateCalculations(field);
    }
  }

  updateCalculations(field) {
    let tipPercentage = 0;
    this.selectTip(field)
    let tipTargetElement = document.getElementsByClassName('btn-selected')[0];
    let tipTarget = tipTargetElement ? parseFloat(tipTargetElement.value) : 0;
    // let tipTarget = document.getElementsByClassName('btn-selected')[0].value || 0;

    // debugger
    let billAmount = parseFloat(this.billTarget?.value) || 0;
    let numberOfPeople = parseInt(this.peopleTarget?.value) || 0;

    if (field.id === "bill-input-value") {
      billAmount = parseFloat(field.value) || 0;
    } else if (field.classList.contains("customTip")) {
      tipPercentage = parseFloat(field.value) || 0;
    } else if (field.id === "numberOfPeopleInputValue") {
      numberOfPeople = parseInt(field.value) || 0;
    }

    this.clearErrorMessages();

    this.saveCalculation(billAmount, tipTarget, numberOfPeople);
  }

  selectTip(field) {
    if (field.classList.contains('tip-button')) {
      document.querySelectorAll('.tip-button').forEach(tipButton => tipButton.classList.remove('btn-selected'));
      field.classList.add('btn-selected');
    }
  }

  clearErrorMessages() {
    const errorElements = document.querySelectorAll('.text-danger');
    errorElements.forEach(element => {
      element.innerText = '';
    });
  }

  displayError(message) {
    const errorElement = document.getElementById('error');
    if (errorElement) {
      errorElement.innerText = message;
    }
  }

  saveCalculation(billAmount, tipTarget, numberOfPeople) {
    fetch("/calculations", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({
        calculation: {
          bill_amount: billAmount,
          tip_percentage: tipTarget,
          number_of_people: numberOfPeople
        }
      })
    })

    .then( response => response.json())
    .then(data => {
      if (data.errors) {
        this.displayError(data.errors.join(', '));
      } else {
        this.tipAmountTarget.innerHTML = `$${data['calculation'].tip_amount}`
        this.totalAmountTarget.innerHTML = `$${data['calculation'].per_person_amount}`

      }
    });
  }

  resetForm() {
    this.billTarget.value = '';
    this.tipTarget.value = '';
    this.peopleTarget.value = '';
    document.querySelectorAll('.tip-button').forEach(tipButton => tipButton.classList.remove('btn-selected'));
    this.tipAmountTarget.innerHTML = '$0.00';
    this.totalAmountTarget.innerHTML = '$0.00';
  }
}
