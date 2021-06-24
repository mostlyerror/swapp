import React from 'react'
import Button from './Button'
import ButtonOutline from './ButtonOutline'
import SwappyChillin from './SwappyChillin'

export const Step5 = (props) => {
  return (
    <div className="p-4">
      <div className="flex gap-6">
        <div className="w-1/4 p-4">
          <SwappyChillin />
        </div>
        <div className="flex-1">
          <h2 className="font-semibold">Review Details</h2>
          <p className="mt-4 text-2xl leading-relaxed">
            Confirm check-in, check-out, and intake dates are correct. Swappy
            says,{' '}
            <em>
              "You can always go back and make changes if things look funny!"
            </em>
          </p>
        </div>
      </div>
      <div className="mt-12 p-8 text-4xl tabular-nums">
        <div className="flex gap-6">
          <div className="flex flex-col p-6 gap-2 bg-white rounded-xl">
            <span className="text-2xl font-bold uppercase tracking-wide">
              Check In
            </span>
            <span>{props.checkIn.toLocaleDateString()}</span>
          </div>
          <div className="flex flex-col p-6 gap-2 bg-white rounded-xl">
            <span className="text-2xl font-bold uppercase tracking-wide">
              Check Out
            </span>
            <span>{props.checkOut.toLocaleDateString()}</span>
          </div>
        </div>
        <div className="mt-4 flex flex-col p-6 gap-2 bg-white rounded-xl">
          <span className="text-2xl font-bold uppercase tracking-wide">
            Intake Dates
          </span>
          <div className="flex flex-col">
            {props.intakeDates.map((date, idx) => (
              <li key={idx}>{date.toLocaleDateString()}</li>
            ))}
          </div>
        </div>
      </div>
      <div className="p-8 flex justify-center gap-8">
        <ButtonOutline onClick={props.back}>
          <span className="text-3xl font-semibold">&larr; Back: Nope</span>
        </ButtonOutline>
        <Button type="submit">
          <span className="text-3xl font-semibold">
            Looks good, let's go! &rarr;
          </span>
        </Button>
      </div>
    </div>
  )
}
