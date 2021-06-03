import React from 'react'

export function Step2(props) {
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
