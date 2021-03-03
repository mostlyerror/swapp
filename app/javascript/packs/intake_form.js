const sleepLastNightInput = document.getElementById(
  "intake_survey[where_did_you_sleep_last_night]_other"
);
const sleepLastNightRadio = document.getElementById(
  "intake_survey[where_did_you_sleep_last_night]_other_radio"
);

sleepLastNightInput.onchange = function () {
  sleepLastNightRadio.setAttribute("checked", "checked");
  sleepLastNightRadio.value = `Other: ${sleepLastNightInput.value}`;
};


const whyNotShelterInput = document.getElementById(
	"intake_survey[why_not_shelter]_other_text_field"
);
const whyNotShelterCheckbox = document.getElementById(
	"intake_survey[why_not_shelter]_other_checkbox"
);

whyNotShelterInput.onchange = function () {
  whyNotShelterCheckbox.setAttribute("checked", "checked");
  whyNotShelterCheckbox.value = `Other: ${whyNotShelterInput.value}`;
};
