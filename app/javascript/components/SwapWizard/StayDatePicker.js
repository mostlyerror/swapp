import React from 'react'
import DayPicker, { DateUtils } from 'react-day-picker'
import 'react-day-picker/lib/style.css'
import './StayDatePicker.css'

export default class StayDatePicker extends React.Component {
  static defaultProps = {
    numberOfMonths: 2,
    canChangeMonth: false,
    showOutsideDays: true,
    enableOutsideDaysClick: false,
  }

  constructor(props) {
    super(props)
    this.handleDayClick = this.handleDayClick.bind(this)
    this.handleResetClick = this.handleResetClick.bind(this)
    this.state = this.getInitialState()
  }

  getInitialState() {
    return {
      from: this.props.from,
      to: this.props.to,
    }
  }

  handleDayClick(day) {
    const range = DateUtils.addDayToRange(day, this.state)
    this.setState(range)
    this.props.onStayDatesChange(range)
  }

  handleResetClick() {
    const stayDates = { from: undefined, to: undefined }
    this.setState(stayDates)
    this.props.onStayDatesChange(stayDates)
  }

  render() {
    const { from, to } = this.state
    const modifiers = { start: from, end: to }

    return (
      <div>
        <DayPicker
          className="StayDayPicker tabular-nums"
          numberOfMonths={this.props.numberOfMonths}
          showOutsideDays={this.props.showOutsideDays}
          canChangeMonth={this.props.canChangeMonth}
          selectedDays={[from, { from, to }]}
          modifiers={modifiers}
          onDayClick={this.handleDayClick}
        />
        <div className="text-2xl">
          {!from && !to && (
            <p className="">
              When is <span className="font-bold">check-in?</span>
            </p>
          )}
          {from && !to && (
            <p className="">
              When is <span className="font-bold">check-out?</span>
            </p>
          )}
          {from && to && (
            <div className="mt-4 flex justify-center items-center gap-8 text-2xl">
              <div>
                <span className="font-bold">Check-in:</span>{' '}
                {from.toLocaleDateString()}
              </div>
              <div>
                <span className="font-bold">Check-out:</span>{' '}
                {to.toLocaleDateString()}
              </div>
              <button className="link" onClick={this.handleResetClick}>
                Reset
              </button>
            </div>
          )}
        </div>
      </div>
    )
  }
}
