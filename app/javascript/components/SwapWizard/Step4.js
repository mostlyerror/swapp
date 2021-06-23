import React from 'react'
import Button from './Button'
import ButtonOutline from './ButtonOutline'
import SwappyChillin from './SwappyChillin'

export function Step4(props) {
  return (
    <div>
      <div className="flex gap-6">
        <div className="w-1/5">
          <SwappyChillin />
        </div>
        <div className="flex-1">
          <h2 className="font-semibold">Update Hotel Availability</h2>
          <p className="mt-4 text-2xl leading-relaxed">
            On each intake day, you can set the voucher supply for that day.
          </p>
        </div>
      </div>
      <div className="mt-4">
        <img src="https://media.giphy.com/media/HIYW8sTRTHt1m/giphy.gif" />
        <div className="mt-6 flex justify-between">
          <ButtonOutline onClick={props.back}>
            Back: Set Intake Dates
          </ButtonOutline>
          <Button onClick={props.advance}>Next: Review</Button>
        </div>
      </div>
    </div>
  )
}
