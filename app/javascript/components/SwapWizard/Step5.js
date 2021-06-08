import React from 'react'
import Button from './Button'
import ButtonOutline from './ButtonOutline'

// review & create
export const Step5 = (props) => {
  return (
    <>
      <h2>A New SWAP Period will be created:</h2>
      <div>
        <div className="flex">
          <div className="flex flex-col">
            <div>Check-In</div>
            <div>{JSON.stringify(props.checkIn)}</div>
          </div>
          <div className="flex flex-col">
            <div>Check-Out</div>
            <div>{JSON.stringify(props.checkOut)}</div>
          </div>
        </div>
        <div>{JSON.stringify(props.intakeDates)}</div>
      </div>
      <ButtonOutline onClick={props.back}>Back: Availability</ButtonOutline>
      <Button type="submit">Looks good, let's go! </Button>
    </>
  )
}
