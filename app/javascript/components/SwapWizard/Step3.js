import React from 'react'
import IntakeDatePicker from './IntakeDatePicker'
import Button from './Button'
import ButtonOutline from './ButtonOutline'
import { SwapWizardTransition } from './SwapWizardTransition'

export const Step3 = (props) => {
  return (
    <div className="text-center">
      <div className="">
        <h3 className="font-semibold">Set Intake Days</h3>
        <p className="mt-4 text-xl">
          On each <span className="font-semibold italic">intake day</span>,
          intake users will be able to issue vouchers to clients. Intake
          typically begins one day prior to the actual check-in, and may
          continue up until the day immediately before the check-out day.
        </p>
      </div>
      <div className="mt-4">
        <IntakeDatePicker
          selectedDays={props.intakeDates}
          stayDates={props.stayDates}
          onIntakeDatesChange={props.onIntakeDatesChange}
        />
        <SwapWizardTransition>
          <div className="mt-8">
            <ButtonOutline onClick={props.back}>Back: Stay Dates</ButtonOutline>
            {props.canAdvance && (
              <Button onClick={props.advance}>Next: Availability</Button>
            )}
          </div>
        </SwapWizardTransition>
      </div>
    </div>
  )
}
