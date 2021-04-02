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
