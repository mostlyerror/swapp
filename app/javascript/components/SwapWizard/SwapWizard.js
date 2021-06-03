import React from 'react'
import { Transition } from '@headlessui/react'
import { Step1 } from './Step1'
import { Step2 } from './Step2'
import { Step3 } from './Step3'
import { Step4 } from './Step4'
import { Step5 } from './Step5'
import _ from 'lodash'

class SwapWizard extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      currentStep: 1,
      stayDateStart: '',
      stayDateEnd: '',
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

  handleChange = (event) => {
    const { name, value } = event.target
    this.setState({
      [name]: value,
    })
  }

  handleSubmit = (event) => {
    event.preventDefault()
    const { stayDates, intakeDates } = this.state
    alert(
      `Your registration detail: \n stayDates: ${stayDates} \n intakeDates: ${intakeDates} `
    )
  }

  render() {
    return (
      <div>
        <h1>Create SWAP Period️</h1>
        <p>Step {this.state.currentStep} </p>

        <form onSubmit={this.handleSubmit}>
          {this.state.currentStep === 1 && (
            <Transition
              appear={true}
              show={true}
              enter="transition-opacity duration-500"
              enterFrom="opacity-0"
              enterTo="opacity-100"
              leave="transition-opacity duration-500"
              leaveFrom="opacity-100"
              leaveTo="opacity-0"
            >
              <Step1
                advance={this.advance}
                currentStep={this.state.currentStep}
                handleChange={this.handleChange}
                stayDates={this.state.stayDates}
              />
            </Transition>
          )}

          {this.state.currentStep === 2 && (
            <Transition
              appear={true}
              show={true}
              enter="transition-opacity duration-500"
              enterFrom="opacity-0"
              enterTo="opacity-100"
              leave="transition-opacity duration-500"
              leaveFrom="opacity-100"
              leaveTo="opacity-0"
            >
              <Step2
                back={this.back}
                advance={this.advance}
                currentStep={this.state.currentStep}
                handleChange={this.handleChange}
                intakeDates={this.state.intakeDates}
              />
            </Transition>
          )}

          {this.state.currentStep === 3 && (
            <Transition
              appear={true}
              show={true}
              enter="transition-opacity duration-500"
              enterFrom="opacity-0"
              enterTo="opacity-100"
              leave="transition-opacity duration-500"
              leaveFrom="opacity-100"
              leaveTo="opacity-0"
            >
              <Step3
                back={this.back}
                advance={this.advance}
                currentStep={this.state.currentStep}
                handleChange={this.handleChange}
              />
            </Transition>
          )}

          {this.state.currentStep === 4 && (
            <Transition
              appear={true}
              show={true}
              enter="transition-opacity duration-500"
              enterFrom="opacity-0"
              enterTo="opacity-100"
              leave="transition-opacity duration-500"
              leaveFrom="opacity-100"
              leaveTo="opacity-0"
            >
              <Step4
                back={this.back}
                advance={this.advance}
                currentStep={this.state.currentStep}
                handleChange={this.handleChange}
              />
            </Transition>
          )}

          {this.state.currentStep === 5 && (
            <Transition
              appear={true}
              show={true}
              enter="transition-opacity duration-500"
              enterFrom="opacity-0"
              enterTo="opacity-100"
              leave="transition-opacity duration-500"
              leaveFrom="opacity-100"
              leaveTo="opacity-0"
            >
              <Step5
                back={this.back}
                createSwapPeriod={this.createSwapPeriod}
                currentStep={this.state.currentStep}
                handleChange={this.handleChange}
              />
            </Transition>
          )}
        </form>
      </div>
    )
  }
}

export default SwapWizard
