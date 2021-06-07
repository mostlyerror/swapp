import React from 'react'
import _ from 'lodash'
import axios from 'axios'
import { SwapWizardTransition } from './SwapWizardTransition'
import { Step1 } from './Step1'
import { Step2 } from './Step2'
import { Step3 } from './Step3'
import { Step4 } from './Step4'
import { Step5 } from './Step5'

class SwapWizard extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      currentStep: 1,
      stayDates: {},
      stayDatesValid: false,
      intakeDates: [],
      intakeDatesValid: false,
    }
  }

  back = (event) => {
    this.setState((prevState) => ({
      currentStep: _.max([prevState.currentStep - 1, 1]),
    }))
  }

  advance = (event) => {
    this.setState((prevState) => ({
      currentStep: _.min([prevState.currentStep + 1, 5]),
    }))
  }

  handleStayDatesChange = (stayDates) => {
    this.setState({ stayDates })
    const values = Object.values(stayDates)
    this.setState({
      stayDatesValid: _.indexOf(values, undefined) === -1,
    })
  }

  handleIntakeDatesChange = (intakeDates) => {
    this.setState({ intakeDates })
    // at least one intake date defined
    // can't have intake after stayDatesEnd -1
  }

  handleSubmit = (event) => {
    event.preventDefault()
    alert(JSON.stringify(this.state))
    const createAdminSwapPeriodURL = `/admin/swaps`

    axios.post(createAdminSwapPeriodURL, this.state)
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

          {this.state.currentStep === 3 && (
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

          {this.state.currentStep === 4 && (
            <SwapWizardTransition>
              <Step4
                back={this.back}
                advance={this.advance}
                currentStep={this.state.currentStep}
              />
            </SwapWizardTransition>
          )}

          {this.state.currentStep === 5 && (
            <SwapWizardTransition>
              <Step5 back={this.back} currentStep={this.state.currentStep} />
            </SwapWizardTransition>
          )}
        </form>
      </div>
    )
  }
}

export default SwapWizard
