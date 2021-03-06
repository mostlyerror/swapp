const questionKeys = [
  "intake_homelessness_first_time",
  "intake_episodes_last_three_years_fewer_than_four_times",
  "intake_armed_forces",
  "intake_active_duty",
  "intake_substance_abuse",
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
