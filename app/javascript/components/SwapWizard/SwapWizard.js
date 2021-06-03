import React from 'react'
import { Transition } from '@headlessui/react'
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
      stayDates: '',
      intakedates: '',
    }
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

  _next = () => {
    let currentStep = this.state.currentStep
    currentStep = currentStep >= 4 ? 5 : currentStep + 1
    this.setState({
      currentStep: currentStep,
    })
  }

  _prev = () => {
    let currentStep = this.state.currentStep
    currentStep = currentStep <= 1 ? 1 : currentStep - 1
    this.setState({
      currentStep: currentStep,
    })
  }

  previousButton() {
    let currentStep = this.state.currentStep
    if (currentStep !== 1) {
      return (
        <button
          className="btn btn-secondary"
          type="button"
          onClick={this._prev}
        >
          Previous
        </button>
      )
    }
    return null
  }

  nextButton() {
    let currentStep = this.state.currentStep
    if (currentStep < 5) {
      return (
        <button
          className="btn btn-primary float-right"
          type="button"
          onClick={this._next}
        >
          Next
        </button>
      )
    }
    return null
  }

  render() {
    return (
      <React.Fragment>
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
              <Step5
                currentStep={this.state.currentStep}
                handleChange={this.handleChange}
              />
            </Transition>
          )}

          {this.previousButton()}
          {this.nextButton()}
        </form>
      </React.Fragment>
    )
  }
}

export default SwapWizard
