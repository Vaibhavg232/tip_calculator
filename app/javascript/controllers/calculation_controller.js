import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["bill", "tip", "people", "tipAmount", "totalAmount"];

  connect() {
    console.log("connected");
  }

  // updateCalculations() {
  //   clearTimeout(this.delayTimeout); // Clear any previous timeouts to prevent multiple executions
  
  //   // Set a delay of 500ms (adjust as needed)
  //   this.delayTimeout = setTimeout(() => {
  //     const billAmount = parseFloat(this.billTarget?.value) || 0;
  //     let tipPercentage = parseFloat(this.tipTarget?.value) || 0; 
  //     const numberOfPeople = parseInt(this.peopleTarget?.value) || 1;
  
  //     const customTip = parseFloat(this.tipTarget?.value) || parseFloat(this.customTipTarget?.value);
  //     if (!isNaN(customTip)) {
  //       tipPercentage = customTip;
  //     }
  
  //     if (numberOfPeople <= 0) {
  //       alert("Number of people cannot be zero or less");
  //       return;
  //     }

  //     console.log("tip percentage.............", tipPercentage)
  //     console.log("tip target value .............", this.tipTarget)
  
  //     const tipAmount = (billAmount * tipPercentage) / 100;
  //     const totalAmount = billAmount + tipAmount;
  //     const perPersonAmount = totalAmount / numberOfPeople;
  
  //     this.tipAmountTarget.innerHTML = `$${tipAmount.toFixed(2)}`;
  //     this.totalAmountTarget.innerHTML = `$${perPersonAmount.toFixed(2)}`;
  //     this.saveCalculation(billAmount, tipPercentage, numberOfPeople, tipAmount, perPersonAmount);
  //   }, 1000); // Adjust delay time in milliseconds
  // }  


  updateCalculations(event) {
    clearTimeout(this.delayTimeout); // Clear any previous timeouts to prevent multiple executions
    
    // Manually set the tipTarget value based on the clicked button's text
    const buttonValue = event.target.innerText.trim();  // Get the button text (e.g., "5%", "10%", etc.)
    const tipPercentage = parseInt(buttonValue.replace('%', '')); // Extract the percentage value (e.g., 5 from "5%")
    
    // Set the value of the `tip` target to the calculated percentage
    this.tipTarget.value = tipPercentage;

    this.delayTimeout = setTimeout(() => {
      const billAmount = parseFloat(this.billTarget?.value) || 0;
      let finalTipPercentage = parseFloat(this.tipTarget?.value) || 0;

      const numberOfPeople = parseInt(this.peopleTarget?.value) || 1;

      if (numberOfPeople <= 0) {
        alert("Number of people cannot be zero or less");
        return;
      }

      console.log("tip percentage.............", finalTipPercentage);
      console.log("tip target value .............", this.tipTarget?.value);

      const tipAmount = (billAmount * finalTipPercentage) / 100;
      const totalAmount = billAmount + tipAmount;
      const perPersonAmount = totalAmount / numberOfPeople;

      this.tipAmountTarget.innerHTML = `$${tipAmount.toFixed(2)}`;
      this.totalAmountTarget.innerHTML = `$${perPersonAmount.toFixed(2)}`;
      this.saveCalculation(billAmount, finalTipPercentage, numberOfPeople, tipAmount, perPersonAmount);
    }, 1000); // Adjust delay time in milliseconds
  }

  saveCalculation(billAmount, tipPercentage, numberOfPeople, tipAmount, perPersonAmount) {
    fetch("/calculations", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({
        calculation: {
          bill_amount: billAmount,
          tip_percentage: tipPercentage,
          number_of_people: numberOfPeople,
          tip_amount: tipAmount,
          total_amount: perPersonAmount * numberOfPeople, 
          per_person_amount: perPersonAmount
        }
      })
    })
    .then(response => response.json())
    .then(data => {
      if (data.errors) {
        console.error("Errors:", data.errors);
      } else {
        
      }
    });
  }

  resetForm() {
    this.billTarget.value = '';
    this.tipTarget.value = '';
    this.peopleTarget.value = '';
    this.customTipTarget.value = '';
    this.tipAmountTarget.innerHTML = '$0.00';
    this.totalAmountTarget.innerHTML = '$0.00';
  }
}
