import React from 'react'
import IntakeDatePicker from './IntakeDatePicker'
import Button from './Button'
import ButtonOutline from './ButtonOutline'

// set intake dates
export const Step3 = (props) => {
  return (
    <div className="">
      <div className="">
        <h3 className="font-semibold tracking-wide">Set Intake Days</h3>
        <p className="mt-4">
          On each <span className="font-semibold italic">intake day</span>,
          intake users will be able to issue vouchers to clients. Intake often
          begins one day prior to the actual check-in, and may continue until
          the day before the check-out.
        </p>
      </div>
      <div className="mt-4 text-center">
        <IntakeDatePicker
          stayDates={props.stayDates}
          onIntakeDatesChange={props.onIntakeDatesChange}
        />
        <div className="flex justify-between">
          <ButtonOutline onClick={props.back}>
            Back: Set Stay Dates
          </ButtonOutline>
          {props.canAdvance && (
            <Button onClick={props.advance}>Next: Availability</Button>
          )}
        </div>
      </div>
    </div>
  )
}
