import React from 'react'
import ButtonOutline from './ButtonOutline'

// first empty state
export const Step1 = (props) => {
  return (
    <div className="flex gap-2">
      <div className="flex-1">
        <h3 className="font-semibold tracking-wide">No Active SWAP Period</h3>
        <div className="mt-4 text-gray-500">
          <p className="mt-4">The activation process is simple:</p>
          <ul className="mt-2 ml-2 space-y-2">
            <li>1. Set dates for the hotel stay period</li>
            <li>2. Set dates to perform client intake</li>
            <li>3. Each intake day, update hotel availability</li>
          </ul>
          <div className="mt-4">
            <ButtonOutline onClick={props.advance}>
              <span className="inline-flex items-center text-xl">
                Get Started &rarr;
              </span>
            </ButtonOutline>
          </div>
        </div>
      </div>
      <div className="">
        <img className="w-full" src="https://i.imgur.com/NNJS2hi.png"></img>
      </div>
    </div>
  )
}
