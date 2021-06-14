import React from 'react'
import StayDatePicker from './StayDatePicker'
import Button from './Button'
import ButtonOutline from './ButtonOutline'
import { SwapWizardTransition } from './SwapWizardTransition'
import SwappyChillin from './SwappyChillin'

export const Step2 = (props) => {
  return (
    <div className="">
      <div className="flex px-5 gap-6">
        <div className="w-1/2">
          <SwappyChillin />
        </div>
        <div className="text-left">
          <h3 className="font-semibold">Set Stay Period</h3>
          <p className="mt-4 text-xl">
            The <span className="font-semibold italic">stay period</span> is when
            voucher recipients are eligible to actually stay at a hotel. It's similar to selecting a check-in and check-out for a hotel
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
