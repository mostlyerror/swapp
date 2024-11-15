import React from 'react'
import StayDatePicker from './StayDatePicker'
import Button from './Button'
import ButtonOutline from './ButtonOutline'
import { SwapWizardTransition } from './SwapWizardTransition'
import SwappyChillin from './SwappyChillin'

export const Step2 = (props) => {
  return (
    <div className="py-8 px-4">
      <div className="flex gap-8">
        <div className="w-1/4 p-4">
          <SwappyChillin />
        </div>
        <div className="flex-1">
          <h2 className="font-bold">Set Stay Period</h2>
          <p className="mt-4 text-2xl leading-relaxed">
            The <span className="font-semibold italic">stay period</span> includes
            the dates when voucher recipients are permitted to stay at a hotel.
            It's similar to selecting a check-in and check-out for a hotel
            reservation.
          </p>
        </div>
      </div>
      <div className="mt-8 text-center">
        <StayDatePicker
          from={props.from}
          to={props.to}
          onStayDatesChange={props.onStayDatesChange}
          preventEditingFromDate={props.preventEditingFromDate}
        />
      </div>
      <div className="p-8 flex justify-center gap-8">
        <ButtonOutline onClick={props.back}>
          <span className="text-3xl font-semibold">&larr; Nevermind</span>
        </ButtonOutline>

        {props.canAdvance && (
          <SwapWizardTransition>
            <Button onClick={props.advance}>
              <span className="text-3xl font-semibold">
                Next: Set Intake Dates &rarr;
              </span>
            </Button>
          </SwapWizardTransition>
        )}
      </div>
    </div>
  )
}
