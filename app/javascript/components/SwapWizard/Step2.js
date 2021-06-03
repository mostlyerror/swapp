import React from 'react'

export function Step2(props) {
  if (props.currentStep !== 2) {
    return null
  }
  return (
    <>
      <label htmlFor="">What are the hotel stay dates?</label>
      <input
        className=""
        id="stayDates"
        name="stayDates"
        type="text"
        value={props.stayDates}
        onChange={props.handleChange}
      />
    </>
  )
}
