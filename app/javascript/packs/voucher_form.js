require("jquery");
require("easy-autocomplete");

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

let guests = 0;
document.addEventListener(
  "click",
  (event) => {
    if (event.target.matches("#add_guest")) {
      let container = document.getElementById("guests");
      let template = document.getElementById("template_guest");
      let clone = template.cloneNode(true);

      guests++;
      clone.classList.remove("hidden");
      clone.classList.add("block");
      clone.id = `guest_${guests}`;

      // let select = clone.querySelectorAll("select").forEach((select) => {
      //   select.id = select.id.replace("replace", guests);
      //   select.name = select.name.replace("replace", guests);
      // });

      clone.querySelectorAll("label").forEach((label) => {
        label.name = label.htmlFor.replace("replace", guests);
      });

      clone.querySelectorAll("input").forEach((input) => {
        input.id = input.id.replace("replace", guests);
        input.name = input.name.replace("replace", guests);
      });

      container.appendChild(clone);
    }
  },
  false
);
document.addEventListener("turbolinks:load", function () {
  const $input = $('*[data-behavior="autocomplete"]');
  const options = {
    url: function (term) {
      return "/clients/search.json?q=" + term;
    },
    getValue: (el) => el.name,
  };

  $input.easyAutocomplete(options);
});
