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
