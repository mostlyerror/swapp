<<<<<<< HEAD
document.addEventListener("change", (event) => {
	if (event.target.matches("#where_did_you_sleep_last_night_other_text_field")) {
		const sleepLastNightInput = document.getElementById(
			"where_did_you_sleep_last_night_other_text_field"
		)
		const sleepLastNightRadio = document.getElementById(
			"where_did_you_sleep_last_night_other_radio"
		)

		sleepLastNightRadio.setAttribute("checked", "checked");
		sleepLastNightRadio.value = `Other: ${sleepLastNightInput.value}`;
	}
}, false)

document.addEventListener("change", (event) => {
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
}, false)

document.addEventListener("click", (event) => {
	if (event.target.matches(".household_composition_changed_yes")) {
		document.getElementById("family_members_container").classList.remove("hidden")
	}
}, false);

document.addEventListener("click", (event) => {
	if (event.target.matches(".household_composition_changed_no")) {
		document.getElementById("family_members_container").classList.add("hidden")
	}
}, false);

let familyMembers = 0;
document.addEventListener("click", (event) => {
	if (event.target.matches("#add_family_member")) {
		let template = document.getElementById("template_family_member");
		let container = document.getElementById("family_members");
		let clone = template.cloneNode(true)

		clone.classList.remove('hidden')
		clone.classList.add('block')
		clone.id = `family_member_${++familyMembers}`

		let select = clone.querySelector('select')
		select.name = select.name.replace("replace", familyMembers);

		clone.querySelectorAll('label')
			.forEach(label => { 
				label.name = label.htmlFor.replace("replace", familyMembers);
			});

		clone.querySelectorAll('input')
			.forEach(input => { 
				input.name = input.name.replace("replace", familyMembers);
				if (input.type != 'checkbox') input.value = ''
			});

		container.appendChild(clone);
	}
}, false);
=======
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
>>>>>>> 81f1f12cb6be2f93e4bdb0be295d2865f63f0c8e
