import React from 'react'
import Button from './Button'
import ButtonOutline from './ButtonOutline'

// review & create
export function Step5(props) {
  const createSwapPeriod = () => {
    return false
  }

  return (
    <>
      <h2>A New SWAP Period will be created:</h2>
      <div>Check In May 20</div>
      <div>Check Out May 22</div>
      <div>Intake Dates May 19 May 20 May 21</div>
      <ButtonOutline onClick={props.back}>Back: Availability</ButtonOutline>
      <Button type="submit">Looks good, let's go! </Button>
    </>
  )
}
