import React from 'react'
import StayDatePicker from './StayDatePicker'
import Button from './Button'
// import ButtonOutline from './ButtonOutline'
import { SwapWizardTransition } from './SwapWizardTransition'

export const Step2 = (props) => {
  return (
    <div className="text-center">
      <div className="">
        <h3 className="font-semibold">Set Stay Period</h3>
        <p className="mt-4 text-xl">
          The <span className="font-semibold italic">stay period</span> is when
          voucher recipients are eligible to actually stay at a hotel.
        </p>
        <p className="text-xl">
          It's similar to selecting a check-in and check-out for a hotel
          reservation.
        </p>
      </div>
      <div className="mt-4">
        <StayDatePicker
          from={props.from}
          to={props.to}
          onStayDatesChange={props.onStayDatesChange}
        />
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
