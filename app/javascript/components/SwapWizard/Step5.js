import React from 'react'
import Button from './Button'
import ButtonOutline from './ButtonOutline'
import SwappyChillin from './SwappyChillin'

export const Step5 = (props) => {
  return (
    <>
      <div className="flex gap-6">
        <div className="w-1/5">
          <SwappyChillin />
        </div>
        <div className="flex-1">
          <h2 className="font-semibold tracking-wide">Review Details</h2>
          <p className="mt-4 text-2xl leading-relaxed">
            Swappy says,{' '}
            <em>
              "You can always go back and make changes if things look funny!"
            </em>
          </p>
        </div>
      </div>
      <div className="mt-12 grid grid-cols-2 gap-6 max-w-2xl text-3xl mx-auto tabular-nums">
        <div className="flex justify-between">
          <span className="font-bold">Check In</span>
          <span>{props.checkIn.toLocaleDateString()}</span>
        </div>
        <div className="flex justify-between">
          <span className="font-bold">Check Out</span>
          <span>{props.checkOut.toLocaleDateString()}</span>
        </div>
        <div className="col-span-2">
          <div className="font-bold">Intake Dates</div>
          <div className="mt-2">
            {props.intakeDates
              .map((date, idx) => date.toLocaleDateString())
              .join(', ')}
          </div>
        </div>
      </div>
      <div className="mt-8 flex justify-between">
        <ButtonOutline onClick={props.back}>
          Back: I want to make changes
        </ButtonOutline>
        <Button type="submit">Looks good, let's go! </Button>
      </div>
    </>
  )
}
