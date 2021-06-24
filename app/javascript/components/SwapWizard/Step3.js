import React from 'react'
import IntakeDatePicker from './IntakeDatePicker'
import Button from './Button'
import ButtonOutline from './ButtonOutline'
import { SwapWizardTransition } from './SwapWizardTransition'
import SwappyChillin from './SwappyChillin'

export const Step3 = (props) => {
  return (
    <div className="p-4">
      <div className="flex gap-6">
        <div className="w-1/4 p-4">
          <SwappyChillin />
        </div>
        <div className="flex-1">
          <h2 className="font-semibold">Set Intake Days</h2>
          <p className="mt-4 text-2xl leading-relaxed">
            On each <span className="font-semibold italic">intake day</span>,
            users will be able to issue vouchers. Intake typically begins one
            day prior to the actual check-in, and may continue up until the day
            before check-out.
          </p>
        </div>
      </div>
      <div className="mt-8 text-center">
        <IntakeDatePicker
          selectedDays={props.intakeDates}
          stayDates={props.stayDates}
          onIntakeDatesChange={props.onIntakeDatesChange}
        />
      </div>
      <div className="p-8 flex justify-center gap-8">
        <ButtonOutline onClick={props.back}>
          <span className="text-3xl font-semibold">
            &larr; Back: Stay Dates
          </span>
        </ButtonOutline>
        {props.canAdvance && (
          <SwapWizardTransition>
            <Button onClick={props.advance}>
              <span className="text-3xl font-semibold">
                Next: Availability &rarr;
              </span>
            </Button>
          </SwapWizardTransition>
        )}
      </div>
    </div>
  )
}
