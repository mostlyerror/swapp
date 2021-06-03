import React from 'react'
import _ from 'lodash'
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
      intakeDates: [],
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

  handleStayDatesChange = (stayDates) => this.setState({ stayDates })

  validateStayDates = (event) => {
    console.log('validateStayDates()')
    this.advance()
  }

  handleIntakeDatesChange = (intakeDates) => {
    console.log('handleIntakeDatesChange()')
    console.log(intakeDates)
    this.setState({ intakeDates })
  }

  validateIntakeDates = (event) => {
    console.log('validateIntakeDates()')
    // sort dates array
    // then validate against the swap dates
    this.advance()
  }

  handleSubmit = (event) => {
    event.preventDefault()
    alert('blah')
    // actually communicate with the server here
  }

  render() {
    return (
      <div>
        <h1>Create SWAP Period️</h1>
        <p>Step {this.state.currentStep} </p>

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
                validateStayDates={this.validateStayDates}
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
                validateIntakeDates={this.validateIntakeDates}
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
