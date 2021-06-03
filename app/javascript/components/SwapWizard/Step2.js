import React from 'react'
import StayDatePicker from './StayDatePicker'
import Button from './Button'
import ButtonOutline from './ButtonOutline'

// set stay dates
export const Step2 = (props) => {
  return (
    <>
      <label htmlFor="">What are the hotel stay dates?</label>
      <StayDatePicker onStayDatesChange={props.onStayDatesChange} />
      <ButtonOutline onClick={props.back}>Back</ButtonOutline>
      <Button onClick={props.validateStayDates}>Next: Set Intake Dates</Button>
    </>
  )
}
