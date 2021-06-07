import React from 'react'
import DayPicker, { DateUtils } from 'react-day-picker'
import 'react-day-picker/lib/style.css'
import './IntakeDatePicker.css'
import { getDaysArray } from '../utils'

export default class IntakeDatePicker extends React.Component {
  static defaultProps = {
    numberOfMonths: 2,
    canChangeMonth: false,
    showOutsideDays: true,
  }

  constructor(props) {
    super(props)
    this.handleDayClick = this.handleDayClick.bind(this)
    this.handleDayMouseEnter = this.handleDayMouseEnter.bind(this)
    this.state = this.getInitialState()
  }

  getInitialState() {
    const { from, to } = this.props.stayDates
    const stayDays = getDaysArray(from, to)

    const modifiers = {
      highlighted: getDaysArray(from, to),
      start: stayDays[0],
      end: stayDays[stayDays.length - 1],
    }

    return {
      modifiers,
      selectedDays: [],
    }
  }

  handleDayClick(day, { selected }) {
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

  // this doesn't happen on tablet view...?
  handleDayMouseEnter(day, modifiers, event) {
    console.log('handleDayMouseEnter')
  }

  render() {
    return (
      <div>
        <DayPicker
          className="IntakeDayPicker"
          numberOfMonths={this.props.numberOfMonths}
          showOutsideDays={this.props.showOutsideDays}
          canChangeMonth={this.props.canChangeMonth}
          selectedDays={this.state.selectedDays}
          modifiers={this.state.modifiers}
          onDayClick={this.handleDayClick}
          onDayMouseEnter={this.handleDayMouseEnter}
        />
      </div>
    )
  }
}
