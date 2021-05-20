<<<<<<< HEAD
// attaching event handlers for yes/no toggles
const questionKeys = [
  "intake_income_source_any",
  "intake_client_attributes_veteran",
  "intake_homelessness_first_time",
  "intake_episodes_last_three_years_fewer_than_four_times",
  "intake_armed_forces",
  "intake_active_duty",
  "intake_chronic_health_condition",
  "intake_mental_health_condition",
  "intake_mental_health_disability",
  "intake_physical_disability",
  "intake_developmental_disability",
  "intake_fleeing_domestic_violence",
];

questionKeys.forEach((key) => {
  document.addEventListener("click", (event) => {
    const radioTrue = document.getElementById(`${key}_true`);
    const radioFalse = document.getElementById(`${key}_false`);
    const buttonYes = document.getElementById(`${key}_yes`);
    const buttonNo = document.getElementById(`${key}_no`);

    if (event.target.id === `${key}_yes`) {
      buttonNo.classList.add("outline-gray-300");
      buttonNo.classList.add("border-gray-300");
      buttonNo.classList.add("text-gray-300");
      buttonNo.classList.remove("bg-indigo-700");
      buttonNo.classList.remove("text-white");

      buttonYes.classList.add("bg-indigo-700");
      buttonYes.classList.add("text-white");
      buttonYes.classList.remove("outline-gray-300");
      buttonYes.classList.remove("border-gray-300");
      buttonYes.classList.remove("text-gray-300");

      radioTrue.checked = true;
      radioFalse.checked = false;
    }

    if (event.target.id === `${key}_no`) {
      buttonYes.classList.add("outline-gray-300");
      buttonYes.classList.add("outline-gray-300");
      buttonYes.classList.add("text-gray-300");
      buttonYes.classList.remove("bg-indigo-700");
      buttonYes.classList.remove("text-white");

      buttonNo.classList.add("bg-indigo-700");
      buttonNo.classList.add("text-white");
      buttonNo.classList.remove("outline-gray-300");
      buttonNo.classList.remove("border--gray-300");
      buttonNo.classList.remove("text-gray-300");

      radioTrue.checked = false;
      radioFalse.checked = true;
    }
  });
});

// non cash benefits
// clicking "No" unchecks the other boxes
// clicking any other box unchecks "No"
document.addEventListener(
  "click",
  (event) => {
    if (event.target.id === "intake_non_cash_benefits_no") {
      const checkboxes = document.querySelectorAll(
        "ul#non_cash_benefits_list > li + li > input"
      );

      if (event.target.checked) {
        checkboxes.forEach((checkbox) => (checkbox.checked = false));
      }
    } else if (event.target.id.match(/intake_non_cash_benefits/)) {
      const noCheckbox = document.getElementById("intake_non_cash_benefits_no");
      noCheckbox.checked = false;
    }
  },
  false
);

// veteran status
document.addEventListener(
  "click",
  (event) => {
    if (event.target.id === "intake_income_source_any_yes") {
      let container = document.getElementById("income_source_container");
      container.classList.remove("hidden");
      let inputs = container.querySelectorAll("input");
      inputs.forEach((input) => {
        input.required = true;
        input.type === "number" && (input.value = "0");
      });
    }

    if (event.target.id === "intake_client_attributes_veteran_yes") {
      let container = document.getElementById("veteran_container");
      container.classList.remove("hidden");
      let inputs = container.querySelectorAll("input");
      inputs.forEach((input) => (input.required = true));
    }
  },
  false
);

document.addEventListener(
  "click",
  (event) => {
    if (event.target.id === "intake_income_source_any_no") {
      let container = document.getElementById("income_source_container");
      container.classList.add("hidden");
      let inputs = container.querySelectorAll("input");
      inputs.forEach((input) => {
        input.required = false;
        input.type === "number" && (input.value = "");
      });
      let totalSpan = document.getElementById("income_source_total");
      totalSpan.innerHTML = "";
    }

    if (event.target.id === "intake_client_attributes_veteran_no") {
      let container = document.getElementById("veteran_container");
      container.classList.add("hidden");
      let inputs = container.querySelectorAll("input");
      inputs.forEach((input) => {
        input.required = false;
        input.type === "radio" && (input.checked = false);
        input.type === "text" && (input.value = "");
      });
    }
  },
  false
);

// calculating approx monthly income total
const incomeSourceContainer = document.getElementById(
  "income_source_container"
);
const incomeSourceInputs = incomeSourceContainer.querySelectorAll("input");

incomeSourceInputs.forEach((input) => {
  input.addEventListener(
    "change",
    (event) => {
      let total = Array.prototype.reduce.call(
        incomeSourceInputs,
        (acc, input) => {
          let parsed = parseInt(input.value);
          if (isNaN(parsed)) {
            parsed = 0;
          }
          return acc + parsed;
        },
        0
      );
      let totalSpan = document.getElementById("income_source_total");
      totalSpan.innerHTML = new Intl.NumberFormat().format(total);
    },
    false
  );
});

=======
>>>>>>> 81f1f12cb6be2f93e4bdb0be295d2865f63f0c8e
document.querySelector("input[type=submit]").addEventListener("click", () => {
  let form = document.querySelector("form");
  if (form.reportValidity()) {
    form.submit();
  }
});
