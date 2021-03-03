const input = document.getElementById(
  "intake_survey[where_did_you_sleep_last_night]_other"
);
const radio = document.getElementById(
  "intake_survey[where_did_you_sleep_last_night]_other_radio"
);

input.onchange = function () {
  radio.setAttribute("checked", "checked");
  radio.value = `Other: ${input.value}`;
};
