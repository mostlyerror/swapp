document.querySelector("input[type=submit]").addEventListener("click", () => {
  let form = document.querySelector("form");
  if (form.reportValidity()) {
    form.submit();
  }
});
