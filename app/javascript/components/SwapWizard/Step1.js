import React from 'react'
import Button from './Button'
import Swappy from 'images/swappy.png'

export const Step1 = (props) => {
  return (
    <div className="flex gap-8">
      <div className="w-1/3">
        <img className="w-full" src={Swappy} />
      </div>
      <div className="flex-1">
        <h2 className="font-semibold">No Active SWAP Period</h2>
        <div className="mt-4 text-gray-500 text-2xl">
          <p className="mt-4">The activation process is simple:</p>
          <ul className="mt-2 ml-2 space-y-2">
            <li>1. Set the hotel stay period</li>
            <li>2. Set client intake dates</li>
            <li>3. Each intake day, update hotel availability!</li>
          </ul>
        </div>
        <div className="mt-8 flex">
          <Button onClick={props.advance}>
            <span className="inline-flex items-center text-xl">
              Get Started &rarr;
            </span>
          </Button>
        </div>
      </div>
    </div>
  )
}
