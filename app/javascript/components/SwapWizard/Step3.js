import React from 'react'

export function Step3(props) {
  return (
    <>
      <label htmlFor="">What days will intake be performed?</label>
      <input
        className=""
        id="intakeDates"
        name="intakeDates"
        type="text"
        value={props.intakeDates}
        onChange={props.handleChange}
      />
    </>
  )
}
