import React from 'react'
import Button from './Button'
import Swappy from 'images/swappy.png'

export const Step1 = (props) => {
  return (
    <div className="p-12">
      <div className="flex gap-6">
        <div className="w-1/3">
          <img className="w-full" src={Swappy} />
        </div>
        <div>
          <h2 className="text-4xl font-semibold">
            Shh.. Swapp's sleeping right now.
          </h2>
          <p className="mt-4 text-2xl">
            But, <strong>activating</strong> is easy:
          </p>
          <ul className="mt-2 space-y-2 text-2xl tabular-nums">
            <li>1. Set the hotel stay period</li>
            <li>2. Set client intake dates</li>
            <li>3. Each intake day, update hotel room availability.</li>
          </ul>
        </div>
      </div>
      <div className="mt-6 flex justify-center">
        <Button onClick={props.advance}>
          <span className="inline-flex items-center font-semibold tracking-wide text-3xl">
            Let's Go! &rarr;
          </span>
        </Button>
      </div>
    </div>
  )
}
