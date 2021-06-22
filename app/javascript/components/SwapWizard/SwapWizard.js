import React from 'react'
import _ from 'lodash'
import axios from 'axios'
import { SwapWizardTransition } from './SwapWizardTransition'
import { Step1 } from './Step1'
import { Step2 } from './Step2'
import { Step3 } from './Step3'
import { Step4 } from './Step4'
import { Step5 } from './Step5'
import SwappyAnimation from './SwappyAnimation'
import { sortDatesArray } from '../utils'

class SwapWizard extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      currentStep: 1,
      stayDates: {},
      stayDatesValid: false,
      intakeDates: [],
      intakeDatesValid: false,
      errors: [],
    }
  }

  back = (event) => {
    this.setState((prevState) => ({
      currentStep: _.max([prevState.currentStep - 1, 1]),
    }))
  }

  advance = (event) => {
    this.setState((prevState) => ({
      currentStep: _.min([prevState.currentStep + 1, 6]),
    }))
  }

  handleStayDatesChange = (stayDates) => {
    this.setState({
      stayDates,
      stayDatesValid: _.indexOf(Object.values(stayDates), undefined) === -1,
      intakeDates: [],
      intakeDatesValid: false,
    })
  }

  handleIntakeDatesChange = (intakeDates) => {
    this.setState({
      intakeDates: sortDatesArray(intakeDates),
      intakeDatesValid: intakeDates.length >= 1,
    })
  }

  handleSubmit = (event) => {
    event.preventDefault()
    const createAdminSwapPeriodURL = `/admin/swaps`
    axios
      .post(createAdminSwapPeriodURL, this.state)
      .then((response) => {
        window.location.reload()
      })
      .catch((error) => {
        this.setState({ errors: error.response.data.errors })
      })
  }

  render() {
    return (
      <div className="bg-indigo-50 rounded-md p-12">
        <form onSubmit={this.handleSubmit}>
          {this.state.currentStep === 1 && (
            <SwapWizardTransition>
              <Step1
                advance={this.advance}
                currentStep={this.state.currentStep}
              />
            </SwapWizardTransition>
          )}
          {this.state.currentStep === 2 && (
            <SwapWizardTransition>
              <SwappyAnimation advance={this.advance} />
            </SwapWizardTransition>
          )}
          {this.state.currentStep === 3 && (
            <SwapWizardTransition>
              <Step2
                back={this.back}
                advance={this.advance}
                currentStep={this.state.currentStep}
                onStayDatesChange={this.handleStayDatesChange}
                canAdvance={this.state.stayDatesValid}
                from={this.state.stayDates.from}
                to={this.state.stayDates.to}
              />
            </SwapWizardTransition>
          )}
          {this.state.currentStep === 4 && (
            <SwapWizardTransition>
              <Step3
                back={this.back}
                advance={this.advance}
                currentStep={this.state.currentStep}
                onIntakeDatesChange={this.handleIntakeDatesChange}
                canAdvance={this.state.intakeDatesValid}
                intakeDates={this.state.intakeDates}
                stayDates={this.state.stayDates}
              />
            </SwapWizardTransition>
          )}
          {this.state.currentStep === 5 && (
            <SwapWizardTransition>
              <Step4
                back={this.back}
                advance={this.advance}
                currentStep={this.state.currentStep}
              />
            </SwapWizardTransition>
          )}
          {this.state.currentStep === 6 && (
            <SwapWizardTransition>
              <Step5
                checkIn={this.state.stayDates.from}
                checkOut={this.state.stayDates.to}
                intakeDates={this.state.intakeDates}
                back={this.back}
                currentStep={this.state.currentStep}
              />
            </SwapWizardTransition>
          )}
        </form>
      </div>
    )
  }
}

export default SwapWizard
