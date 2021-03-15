document.addEventListener("click", (event) => {
  // HOMELESSNESS FIRST TIME

  if (event.target.matches("#homelessness_first_time_yes")) {
    const radio = document.getElementById(
      "intake_homelessness_first_time_true"
    );
    const button = document.getElementById("homelessness_first_time_yes");
    const radioNo = document.getElementById(
      "intake_homelessness_first_time_false"
    );
    const buttonNo = document.getElementById("homelessness_first_time_no");

    buttonNo.classList.remove("bg-indigo-900");
    buttonNo.classList.remove("text-white");

    button.classList.add("bg-indigo-900");
    button.classList.add("text-white");

    radio.value = "true";
    radioNo.value = "false";
  }

  if (event.target.matches("#homelessness_first_time_no")) {
    const radio = document.getElementById(
      "intake_homelessness_first_time_false"
    );
    const button = document.getElementById("homelessness_first_time_no");
    const radioYes = document.getElementById(
      "intake_homelessness_first_time_true"
    );
    const buttonYes = document.getElementById("homelessness_first_time_yes");

    button.classList.add("bg-indigo-900");
    button.classList.add("text-white");

    radio.value = "true";
    radioYes.value = "false";

    buttonYes.classList.remove("bg-indigo-900");
    buttonYes.classList.remove("text-white");
  }

  // ARMED FORCES

  if (event.target.matches("#armed_forces_yes")) {
    const radio = document.getElementById("intake_armed_forces_true");
    const button = document.getElementById("armed_forces_yes");
    const radioNo = document.getElementById("intake_armed_forces_false");
    const buttonNo = document.getElementById("armed_forces_no");

    buttonNo.classList.remove("bg-indigo-900");
    buttonNo.classList.remove("text-white");

    button.classList.add("bg-indigo-900");
    button.classList.add("text-white");

    radio.value = "true";
    radioNo.value = "false";
  }

  if (event.target.matches("#armed_forces_no")) {
    const radio = document.getElementById("intake_armed_forces_false");
    const button = document.getElementById("armed_forces_no");
    const radioYes = document.getElementById("intake_armed_forces_true");
    const buttonYes = document.getElementById("armed_forces_yes");

    button.classList.add("bg-indigo-900");
    button.classList.add("text-white");

    radio.value = "true";
    radioYes.value = "false";

    buttonYes.classList.remove("bg-indigo-900");
    buttonYes.classList.remove("text-white");
  }

  // ACTIVE DUTY NATIONAL GUARD

  if (event.target.matches("#active_duty_yes")) {
    const radio = document.getElementById("intake_active_duty_true");
    const button = document.getElementById("active_duty_yes");
    const radioNo = document.getElementById("intake_active_duty_false");
    const buttonNo = document.getElementById("active_duty_no");

    buttonNo.classList.remove("bg-indigo-900");
    buttonNo.classList.remove("text-white");

    button.classList.add("bg-indigo-900");
    button.classList.add("text-white");

    radio.value = "true";
    radioNo.value = "false";
  }

  if (event.target.matches("#active_duty_no")) {
    const radio = document.getElementById("intake_active_duty_false");
    const button = document.getElementById("active_duty_no");
    const radioYes = document.getElementById("intake_active_duty_true");
    const buttonYes = document.getElementById("active_duty_yes");

    button.classList.add("bg-indigo-900");
    button.classList.add("text-white");

    radio.value = "true";
    radioYes.value = "false";

    buttonYes.classList.remove("bg-indigo-900");
    buttonYes.classList.remove("text-white");
  }

  // SUBSTANCE ABUSE

  if (event.target.matches("#substance_abuse_yes")) {
    const radio = document.getElementById("intake_substance_abuse_true");
    const button = document.getElementById("substance_abuse_yes");
    const radioNo = document.getElementById("intake_substance_abuse_false");
    const buttonNo = document.getElementById("substance_abuse_no");

    buttonNo.classList.remove("bg-indigo-900");
    buttonNo.classList.remove("text-white");

    button.classList.add("bg-indigo-900");
    button.classList.add("text-white");

    radio.value = "true";
    radioNo.value = "false";
  }

  if (event.target.matches("#substance_abuse_no")) {
    const radio = document.getElementById("intake_substance_abuse_false");
    const button = document.getElementById("substance_abuse_no");
    const radioYes = document.getElementById("intake_substance_abuse_true");
    const buttonYes = document.getElementById("substance_abuse_yes");

    button.classList.add("bg-indigo-900");
    button.classList.add("text-white");

    radio.value = "true";
    radioYes.value = "false";

    buttonYes.classList.remove("bg-indigo-900");
    buttonYes.classList.remove("text-white");
  }

  // CHRONIC HEALTH CONDITION

  if (event.target.matches("#chronic_health_condition_yes")) {
    const radio = document.getElementById(
      "intake_chronic_health_condition_true"
    );
    const button = document.getElementById("chronic_health_condition_yes");
    const radioNo = document.getElementById(
      "intake_chronic_health_condition_false"
    );
    const buttonNo = document.getElementById("chronic_health_condition_no");

    buttonNo.classList.remove("bg-indigo-900");
    buttonNo.classList.remove("text-white");

    button.classList.add("bg-indigo-900");
    button.classList.add("text-white");

    radio.value = "true";
    radioNo.value = "false";
  }

  if (event.target.matches("#chronic_health_condition_no")) {
    const radio = document.getElementById(
      "intake_chronic_health_condtion_false"
    );
    const button = document.getElementById("chronic_health_condition_no");
    const radioYes = document.getElementById(
      "intake_chronic_health_condition_true"
    );
    const buttonYes = document.getElementById("chronic_health_condition_yes");

    button.classList.add("bg-indigo-900");
    button.classList.add("text-white");

    radio.value = "true";
    radioYes.value = "false";

    buttonYes.classList.remove("bg-indigo-900");
    buttonYes.classList.remove("text-white");
  }

  // MENATL HEALTH CONDITION

  if (event.target.matches("#mental_health_condition_yes")) {
    const radio = document.getElementById(
      "intake_mental_health_condition_true"
    );
    const button = document.getElementById("mental_health_condition_yes");
    const radioNo = document.getElementById(
      "intake_mental_health_condition_false"
    );
    const buttonNo = document.getElementById("mental_health_condition_no");

    buttonNo.classList.remove("bg-indigo-900");
    buttonNo.classList.remove("text-white");

    button.classList.add("bg-indigo-900");
    button.classList.add("text-white");

    radio.value = "true";
    radioNo.value = "false";
  }

  if (event.target.matches("#mental_health_condition_no")) {
    const radio = document.getElementById(
      "intake_mental_health_condition_false"
    );
    const button = document.getElementById("mental_health_condition_no");
    const radioYes = document.getElementById(
      "intake_mental_health_condition_true"
    );
    const buttonYes = document.getElementById("mental_health_condition_yes");

    button.classList.add("bg-indigo-900");
    button.classList.add("text-white");

    radio.value = "true";
    radioYes.value = "false";

    buttonYes.classList.remove("bg-indigo-900");
    buttonYes.classList.remove("text-white");
  }

  // MENTAL HEALTH DISABILITY

  if (event.target.matches("#mental_health_disability_yes")) {
    const radio = document.getElementById(
      "intake_mental_health_disability_true"
    );
    const button = document.getElementById("mental_health_disability_yes");
    const radioNo = document.getElementById(
      "intake_mental_health_disability_false"
    );
    const buttonNo = document.getElementById("mental_health_disability_no");

    buttonNo.classList.remove("bg-indigo-900");
    buttonNo.classList.remove("text-white");

    button.classList.add("bg-indigo-900");
    button.classList.add("text-white");

    radio.value = "true";
    radioNo.value = "false";
  }

  if (event.target.matches("#mental_health_disability_no")) {
    const radio = document.getElementById(
      "intake_mental_health_disability_false"
    );
    const button = document.getElementById("mental_health_disability_no");
    const radioYes = document.getElementById(
      "intake_mental_health_disability_true"
    );
    const buttonYes = document.getElementById("mental_health_disability_yes");

    button.classList.add("bg-indigo-900");
    button.classList.add("text-white");

    radio.value = "true";
    radioYes.value = "false";

    buttonYes.classList.remove("bg-indigo-900");
    buttonYes.classList.remove("text-white");
  }

  // PHYSICAL DISABILITY

  if (event.target.matches("#physical_disability_yes")) {
    const radio = document.getElementById("intake_physical_disability_true");
    const button = document.getElementById("physical_disability_yes");
    const radioNo = document.getElementById("intake_physical_disability_false");
    const buttonNo = document.getElementById("physical_disability_no");

    buttonNo.classList.remove("bg-indigo-900");
    buttonNo.classList.remove("text-white");

    button.classList.add("bg-indigo-900");
    button.classList.add("text-white");

    radio.value = "true";
    radioNo.value = "false";
  }

  if (event.target.matches("#physical_disability_no")) {
    const radio = document.getElementById("intake_physical_disability_false");
    const button = document.getElementById("physical_disability_no");
    const radioYes = document.getElementById("intake_physical_disability_true");
    const buttonYes = document.getElementById("physical_disability_yes");

    button.classList.add("bg-indigo-900");
    button.classList.add("text-white");

    radio.value = "true";
    radioYes.value = "false";

    buttonYes.classList.remove("bg-indigo-900");
    buttonYes.classList.remove("text-white");
  }

  // DEVELOPMENTAL DISABILITY

  if (event.target.matches("#developmental_disability_yes")) {
    const radio = document.getElementById(
      "intake_developmental_disability_true"
    );
    const button = document.getElementById("developmental_disability_yes");
    const radioNo = document.getElementById(
      "intake_developmental_disability_false"
    );
    const buttonNo = document.getElementById("developmental_disability_no");

    buttonNo.classList.remove("bg-indigo-900");
    buttonNo.classList.remove("text-white");

    button.classList.add("bg-indigo-900");
    button.classList.add("text-white");

    radio.value = "true";
    radioNo.value = "false";
  }

  if (event.target.matches("#developmental_disability_no")) {
    const radio = document.getElementById(
      "intake_developmental_disability_false"
    );
    const button = document.getElementById("developmental_disability_no");
    const radioYes = document.getElementById(
      "intake_developmental_disability_true"
    );
    const buttonYes = document.getElementById("developmental_disability_yes");

    button.classList.add("bg-indigo-900");
    button.classList.add("text-white");

    radio.value = "true";
    radioYes.value = "false";

    buttonYes.classList.remove("bg-indigo-900");
    buttonYes.classList.remove("text-white");
  }

  // DOMESTIC VIOLENCE, SEXUAL ASSAULT AND STALKING

  if (event.target.matches("#fleeing_domestic_violence_yes")) {
    const radio = document.getElementById(
      "intake_fleeing_domestic_violence_true"
    );
    const button = document.getElementById("fleeing_domestic_violence_yes");
    const radioNo = document.getElementById(
      "intake_fleeing_domestic_violence_false"
    );
    const buttonNo = document.getElementById("fleeing_domestic_violence_no");

    buttonNo.classList.remove("bg-indigo-900");
    buttonNo.classList.remove("text-white");

    button.classList.add("bg-indigo-900");
    button.classList.add("text-white");

    radio.value = "true";
    radioNo.value = "false";
  }

  if (event.target.matches("#fleeing_domestic_violence_no")) {
    const radio = document.getElementById(
      "intake_fleeing_domestic_violence_false"
    );
    const button = document.getElementById("fleeing_domestic_violence_no");
    const radioYes = document.getElementById(
      "intake_fleeing_domestic_violence_true"
    );
    const buttonYes = document.getElementById("fleeing_domestic_violence_yes");

    button.classList.add("bg-indigo-900");
    button.classList.add("text-white");

    radio.value = "true";
    radioYes.value = "false";

    buttonYes.classList.remove("bg-indigo-900");
    buttonYes.classList.remove("text-white");
  }
});
