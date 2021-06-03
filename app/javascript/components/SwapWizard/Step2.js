import React from 'react'
import StayDatePicker from './StayDatePicker'

export function Step2(props) {
  return (
    <>
      <label htmlFor="">What are the hotel stay dates?</label>
      <StayDatePicker
        numberOfMonths={2}
        showOutsideDays
        canChangeMonth={false}
      />
    </>
  )
}
