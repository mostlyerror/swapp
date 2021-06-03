import React from 'react'
import IntakeDatePicker from './IntakeDatePicker'
import Button from './Button'
import ButtonOutline from './ButtonOutline'

// set intake dates
export function Step3(props) {
  const validate = (event) => {
    // check that the intake dates are set and valid?
    props.advance()
  }

  return (
    <>
      <label htmlFor="">What days will intake be performed?</label>
      <IntakeDatePicker />
      <ButtonOutline onClick={props.back}>Back: Set Stay Dates</ButtonOutline>
      <Button onClick={validate}>Next: Availability</Button>
    </>
  )
}
