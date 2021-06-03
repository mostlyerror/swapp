import React from 'react'

export function Step4(props) {
  if (props.currentStep !== 4) {
    return null
  }
  return (
    <>
      <h2>On each Intake Day, you can set the voucher supply for that day:</h2>
      <img src="https://media.giphy.com/media/HIYW8sTRTHt1m/giphy.gif" />
    </>
  )
}
