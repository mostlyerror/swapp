import React from 'react'
import Button from './Button'
import ButtonOutline from './ButtonOutline'
import SwappyChillin from './SwappyChillin'

export const Step5 = (props) => {
  return (
    <>
      <div className="flex px-5 gap-6">
        <div className="w-1/3">
          <SwappyChillin />
        </div>
        <div className="flex-1">
          <h3 className="font-semibold tracking-wide">Review</h3>
          <div className="flex">
            <div className="flex flex-col">
              <div className="border border-gray-400">
                <p
                  className="text-center border border-black tracking-wide
                text-xl current-swap font-semibold"
                >
                  Check In
                </p>
                <p className="text-center border border-black text-3xl font-bold current-swap tracking-wide">
                  {props.checkIn.toLocaleDateString()}
                </p>
              </div>
              <div className="border border-gray-400">
                <p className="text-center w-full border border-black tracking-wide text-xl current-swap font-semibold">
                  Check Out
                </p>
                <p className="text-center border border-black text-3xl font-bold current-swap tracking-wide">
                  {props.checkOut.toLocaleDateString()}
                </p>
              </div>
            </div>
            <div className="">
              <div className=""> Intake Dates</div>
              <ul>
                {props.intakeDates.map((date, idx) => (
                  <li key={idx}>{date.toLocaleDateString()}</li>
                ))}
              </ul>
            </div>
          </div>
        </div>
      </div>
      <div className="mt-6 flex justify-between">
        <ButtonOutline onClick={props.back}>
          Back: I want to make changes
        </ButtonOutline>
        <Button type="submit">Looks good, let's go! </Button>
      </div>
    </>
  )
}
