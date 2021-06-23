import React from 'react'
import StayDatePicker from './StayDatePicker'
import Button from './Button'
import ButtonOutline from './ButtonOutline'
import { SwapWizardTransition } from './SwapWizardTransition'
import SwappyChillin from './SwappyChillin'

export const Step2 = (props) => {
  return (
    <div className="">
      <div className="flex gap-8">
        <div className="w-1/5">
          <SwappyChillin />
        </div>
        <div className="flex-1">
          <h2 className="font-semibold">Set Stay Period</h2>
          <p className="mt-4 text-2xl leading-relaxed">
            The <span className="font-semibold italic">stay period</span> is
            when voucher recipients are eligible to actually stay at a hotel.
            It's similar to selecting a check-in and check-out for a hotel
            reservation.
          </p>
        </div>
      </div>
      <div className="text-center mt-4">
        <StayDatePicker
          from={props.from}
          to={props.to}
          onStayDatesChange={props.onStayDatesChange}
        />

        <ButtonOutline onClick={props.back}>Nevermind!</ButtonOutline>

        {props.canAdvance && (
          <SwapWizardTransition>
            <div className="mt-8">
              <Button onClick={props.advance}>Next: Set Intake Dates</Button>
            </div>
          </SwapWizardTransition>
        )}
      </div>
    </div>
  )
}
