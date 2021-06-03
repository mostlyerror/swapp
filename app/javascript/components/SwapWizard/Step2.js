import React from 'react'
import StayDatePicker from './StayDatePicker'
import Button from './Button'
import ButtonOutline from './ButtonOutline'

// set stay dates
export function Step2(props) {
  const validate = (event) => {
    // check that the stay dates are set and valid?
    props.advance()
  }

  return (
    <>
      <label htmlFor="">What are the hotel stay dates?</label>
      <StayDatePicker />
      <ButtonOutline onClick={props.back}>Back</ButtonOutline>
      <Button onClick={validate}>Next: Set Intake Dates</Button>
    </>
  )
}
