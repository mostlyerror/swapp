import React from 'react'
import Button from './Button'
import ButtonOutline from './ButtonOutline'

// a note about setting availability
export function Step4(props) {
  return (
    <>
      <h2>On each Intake Day, you can set the voucher supply for that day:</h2>
      <img src="https://media.giphy.com/media/HIYW8sTRTHt1m/giphy.gif" />
      <ButtonOutline onClick={props.back}>Back: Set Intake Dates</ButtonOutline>
      <Button onClick={props.advance}>Next: Review</Button>
    </>
  )
}