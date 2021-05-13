const questionKeys = ["voucher_guests"];

questionKeys.forEach((key) => {
  document.addEventListener("click", (event) => {
    const radioTrue = document.getElementById(`${key}_true`);
    const radioFalse = document.getElementById(`${key}_false`);
    const buttonYes = document.getElementById(`${key}_yes`);
    const buttonNo = document.getElementById(`${key}_no`);
    const guestsForm = document.getElementById("guests-form-container");

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

      guestsForm.classList.remove("hidden");
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

      guestsForm.classList.add("hidden");
    }
  });
});

document.addEventListener(
  "change",
  (event) => {
    if (
      event.target.matches("#where_did_you_sleep_last_night_other_text_field")
    ) {
      const sleepLastNightInput = document.getElementById(
        "where_did_you_sleep_last_night_other_text_field"
      );
      const sleepLastNightRadio = document.getElementById(
        "where_did_you_sleep_last_night_other_radio"
      );

      sleepLastNightRadio.setAttribute("checked", "checked");
      sleepLastNightRadio.value = `Other: ${sleepLastNightInput.value}`;
    }
  },
  false
);

document.addEventListener(
  "change",
  (event) => {
    if (event.target.matches("#why_not_shelter_other_text_field")) {
      const whyNotShelterInput = document.getElementById(
        "why_not_shelter_other_text_field"
      );
      const whyNotShelterCheckbox = document.getElementById(
        "why_not_shelter_other_checkbox"
      );
      whyNotShelterCheckbox.setAttribute("checked", "checked");
      whyNotShelterCheckbox.value = `Other: ${whyNotShelterInput.value}`;
    }
  },
  false
);
