document.addEventListener("click", (event) => {
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

    // remove bg-indigo-900 from armed_forces_no
    // set radio value to false for armed_forces_no
    // add class to deemphasize armed_forces_no
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
});
