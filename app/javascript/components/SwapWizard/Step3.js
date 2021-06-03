import React from 'react'
import IntakeDatePicker from './IntakeDatePicker'
import Button from './Button'
import ButtonOutline from './ButtonOutline'

// set intake dates
export const Step3 = (props) => {
  return (
    <>
      <label htmlFor="">What days will intake be performed?</label>
      <IntakeDatePicker onIntakeDatesChange={props.onIntakeDatesChange} />
      <ButtonOutline onClick={props.back}>Back: Set Stay Dates</ButtonOutline>
      <Button onClick={props.validateIntakeDates}>Next: Availability</Button>
    </>
  )
}
