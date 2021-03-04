const sleepLastNightInput = document.getElementById(
  "intake_survey[where_did_you_sleep_last_night]_other"
);
const sleepLastNightRadio = document.getElementById(
  "intake_survey[where_did_you_sleep_last_night]_other_radio"
);

sleepLastNightInput.onchange = () => {
  sleepLastNightRadio.setAttribute("checked", "checked");
  sleepLastNightRadio.value = `Other: ${sleepLastNightInput.value}`;
};


const whyNotShelterInput = document.getElementById(
	"intake_survey[why_not_shelter]_other_text_field"
);
const whyNotShelterCheckbox = document.getElementById(
	"intake_survey[why_not_shelter]_other_checkbox"
);

whyNotShelterInput.onchange = () => {
  whyNotShelterCheckbox.setAttribute("checked", "checked");
  whyNotShelterCheckbox.value = `Other: ${whyNotShelterInput.value}`;
};


const addFamilyMemberBtn = document.getElementById("add_family_member");
let familyMembers = 0;

addFamilyMemberBtn.onclick = () => {
	let template = document.getElementById("template_family_member");
	let container = document.getElementById("family_members");
	let clone = template.cloneNode(true)
	clone.classList.remove('hidden')
	clone.classList.add('block')
	clone.id = `family_member_${++familyMembers}`
	clone.querySelectorAll('input')
	     .forEach(input => { input.value = '' });

	container.appendChild(clone);
}
