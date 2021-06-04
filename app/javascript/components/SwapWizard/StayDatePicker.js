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
      <div className="RangeExample">
        <p>
          {!from && !to && 'When is check-in?'}
          {from && !to && 'When is check-out?'}
          {from &&
            to &&
            `Selected from ${from.toLocaleDateString()} to
                ${to.toLocaleDateString()}`}{' '}
          {from && to && (
            <button className="link" onClick={this.handleResetClick}>
              Reset
            </button>
          )}
        </p>
        <DayPicker
          className="Selectable"
          numberOfMonths={this.props.numberOfMonths}
          showOutsideDays={this.props.showOutsideDays}
          canChangeMonth={this.props.canChangeMonth}
          selectedDays={[from, { from, to }]}
          modifiers={modifiers}
          onDayClick={this.handleDayClick}
        />
      </div>
    )
  }
}
