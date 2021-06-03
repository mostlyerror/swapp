import React from 'react'
import Button from './Button'
import ButtonOutline from './ButtonOutline'

// review & create
export const Step5 = (props) => {
  return (
    <>
      <h2>A New SWAP Period will be created:</h2>
      <div>swap details here?</div>
      <ButtonOutline onClick={props.back}>Back: Availability</ButtonOutline>
      <Button type="submit">Looks good, let's go! </Button>
    </>
  )
}
