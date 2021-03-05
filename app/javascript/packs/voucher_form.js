const sleepLastNightInput = document.getElementById(
	"where_did_you_sleep_last_night_other_text_field"
)
const sleepLastNightRadio = document.getElementById(
	"where_did_you_sleep_last_night_other_radio"
)

sleepLastNightInput.onchange = () => {
	sleepLastNightRadio.setAttribute("checked", "checked");
	sleepLastNightRadio.value = `Other: ${sleepLastNightInput.value}`;
};



const whyNotShelterInput = document.getElementById(
	"why_not_shelter_other_text_field"
);
const whyNotShelterCheckbox = document.getElementById(
	"why_not_shelter_other_checkbox"
);

// todo this needs happen on more than just change,
// if you submit and are rejected with errors, the 2nd time around
// the checkbox text field retains the previous input, but
// the checkbox input value has reverted! dun dun dun ....!!!
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
