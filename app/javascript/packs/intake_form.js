document.querySelector('input[type=submit]').addEventListener('click', (e) => {
  e.preventDefault()
  let form = document.querySelector('form')
  if (form.reportValidity()) {
    form.submit()
  }
})