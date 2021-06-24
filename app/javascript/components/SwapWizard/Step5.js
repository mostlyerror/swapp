import React from 'react'
import Button from './Button'
import ButtonOutline from './ButtonOutline'
import SwappyChillin from './SwappyChillin'

export const Step5 = (props) => {
  return (
    <div className="py-8 px-4">
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
      <div className="mt-12 max-w-3xl mx-auto">
        <div className="grid grid-cols-2 gap-8">
          <div className="flex flex-col px-12 py-6 gap-2 bg-white rounded-xl">
            <span className="text-3xl font-bold uppercase tracking-wide">
              Check In
            </span>
            <span className="text-4xl">
              {props.checkIn.toLocaleDateString()}
            </span>
          </div>
          <div className="flex flex-col px-12 py-6 gap-2 bg-white rounded-xl">
            <span className="text-3xl font-bold uppercase tracking-wide">
              Check Out
            </span>
            <span className="text-4xl">
              {props.checkOut.toLocaleDateString()}
            </span>
          </div>
        </div>
        <div className="mt-8 px-12 px-12 py-6 bg-white rounded-xl">
          <span className="text-3xl font-bold uppercase tracking-wide">
            Intake Dates
          </span>
          <div className="mt-4 flex flex-col gap-3">
            {props.intakeDates.map((date, idx) => (
              <li className="text-4xl" key={idx}>
                {date.toLocaleDateString()}
              </li>
            ))}
          </div>
        </div>
      </div>
      <div className="mt-4 p-8 flex justify-center gap-8">
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
