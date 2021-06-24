import React from 'react'
import Button from './Button'
import ButtonOutline from './ButtonOutline'
import SwappyChillin from './SwappyChillin'
import VoucherSupplyGif from 'images/update-voucher-supply.gif'

export function Step4(props) {
  return (
    <div className="py-8 px-4">
      <div className="flex gap-6">
        <div className="w-1/4 p-4">
          <SwappyChillin />
        </div>
        <div className="flex-1">
          <h2 className="font-semibold">Update Hotel Availability</h2>
          <p className="mt-4 text-2xl leading-relaxed">
            Set the voucher supply according to each hotel's room availability{' '}
            <em>on that day</em>. This should be done as early as possible on
            each day of intake.
          </p>
        </div>
      </div>
      <div className="mt-12 text-center">
        <img
          className="w-3/5 mx-auto border border-black rounded-xl"
          src={VoucherSupplyGif}
        />
        <div className="p-8 flex justify-center gap-8">
          <ButtonOutline onClick={props.back}>
            <span className="text-3xl font-semibold">
              &larr; Back: Intake Dates
            </span>
          </ButtonOutline>
          <Button onClick={props.advance}>
            <span className="text-3xl font-semibold">
              Got It! Let's Review &rarr;
            </span>
          </Button>
        </div>
      </div>
    </div>
  )
}
