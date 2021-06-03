import React from 'react'
import DayPicker, { DateUtils } from 'react-day-picker'
import 'react-day-picker/lib/style.css'
import './IntakeDatePicker.css'

export default class IntakeDatePicker extends React.Component {
  static defaultProps = {
    numberOfMonths: 1,
    canChangeMonth: false,
    showOutsideDays: true,
  }

  constructor(props) {
    super(props)
    this.handleDayClick = this.handleDayClick.bind(this)
    this.handleResetClick = this.handleResetClick.bind(this)
    this.state = this.getInitialState()
  }

  getInitialState() {
    return {
      from: undefined,
      to: undefined,
      selectedDays: [],
    }
  }

  handleDayClick(day, { selected }) {
    console.log('day', day)
    console.log('selected', selected)
    const selectedDays = this.state.selectedDays.concat()
    if (selected) {
      const selectedIndex = selectedDays.findIndex((selectedDay) =>
        DateUtils.isSameDay(selectedDay, day)
      )
      selectedDays.splice(selectedIndex, 1)
    } else {
      selectedDays.push(day)
    }
    this.setState({ selectedDays })
    this.props.onIntakeDatesChange(selectedDays)
  }

  handleResetClick() {
    this.setState(this.getInitialState())
    this.props.onIntakeDatesChange(this.getInitialState())
  }

  render() {
    const { from, to } = this.state
    const modifiers = { start: from, end: to }
    return (
      <div className="RangeExample">
        <p>
          {!from && !to && 'Please select the first day.'}
          {from && !to && 'Please select the last day.'}
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
          selectedDays={this.state.selectedDays}
          modifiers={modifiers}
          onDayClick={this.handleDayClick}
        />
      </div>
    )
  }
}
