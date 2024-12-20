import React from 'react'
import _, { update } from 'lodash'
import axios from 'axios'
import { SwapWizardTransition } from './SwapWizardTransition'
import { Step1 } from './Step1'
import { Step2 } from './Step2'
import { Step3 } from './Step3'
import { Step4 } from './Step4'
import { Step5 } from './Step5'
// import SwappyAnimation from './SwappyAnimation'
import { sortDatesArray } from '../utils'
import { DateUtils } from 'react-day-picker'

class SwapWizard extends React.Component {
  constructor(props) {
    super(props)

    if (props.swap) {
      this.state = {
        swap: props.swap,
        numActiveVouchers: props.num_active_vouchers,
        currentStep: 2,
        stayDates: {
          from: new Date(props.swap.start_date.split('-')),
          to: new Date(props.swap.end_date.split('-')),
        },
        stayDatesValid: true,
        originalStayDates: {
          from: new Date(props.swap.start_date.split('-')),
          to: new Date(props.swap.end_date.split('-')),
        },
        intakeDates: props.swap.intake_dates.map(
          (date) => new Date(date.split('-'))
        ),
        intakeDatesValid: true,
        errors: [],
      }
    } else {
      this.state = {
        numActiveVouchers: props.num_active_vouchers,
        currentStep: 1,
        stayDates: { from: null, to: null },
        stayDatesValid: false,
        originalStayDates: { from: null, to: null },
        intakeDates: [],
        intakeDatesValid: false,
        errors: [],
      }
    }
  }

  refresh = () => {
    window.location.replace(window.location.href.split(/[?#]/)[0])
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
    const intakeDates = this.state.intakeDates.filter((date, idx) => {
      return DateUtils.isDayBefore(date, stayDates.to)
    })
    this.setState({
      stayDates,
      stayDatesValid: _.indexOf(Object.values(stayDates), undefined) === -1,
      intakeDates: intakeDates,
      intakeDatesValid: intakeDates.length >= 1,
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

    //This confirms that the user is aware they are changing voucher stay dates.
    let conf = true
    if (this.state.numActiveVouchers > 0 && !DateUtils.isSameDay(this.state.stayDates.to,this.state.originalStayDates.to)) {
      conf = window.confirm(`⚠️ This action will extend ${this.state.numActiveVouchers} vouchers to ${this.state.stayDates.to.toDateString()}. Are you sure? ⚠️`)
    }
    if (!conf)
      return false

    if (this.state.swap) {
      //This updates a swap period that already exists
      const updateAdminSwapPeriodURL = `/admin/swaps/${this.state.swap.id}/update`
      axios
        .put(updateAdminSwapPeriodURL, this.state)
        .then((response) => {
          window.location.replace(window.location.href.split(/[?#]/)[0])
        })
        .catch((error) => {
          this.setState({ errors: error.response.data.errors })
        })
    } else {
      //This creates a swap period when none exists yet
      const createAdminSwapPeriodURL = `/admin/swaps`
      axios
        .post(createAdminSwapPeriodURL, this.state)
        .then((response) => {
          window.location.replace(window.location.href.split(/[?#]/)[0])
        })
        .catch((error) => {
          this.setState({ errors: error.response.data.errors })
        })
    }
  }

  render() {
    return (
      <div className="bg-indigo-50 rounded-md">
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
                back={this.refresh}
                advance={this.advance}
                currentStep={this.state.currentStep}
                onStayDatesChange={this.handleStayDatesChange}
                canAdvance={this.state.stayDatesValid}
                from={this.state.stayDates.from}
                to={this.state.stayDates.to}
                preventEditingFromDate={this.state.numActiveVouchers > 0}
                originalFrom={this.state.originalStayDates.from}
                originalTo={this.state.originalStayDates.to}
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
