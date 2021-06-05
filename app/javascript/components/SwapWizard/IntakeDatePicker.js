import React from 'react'
import DayPicker, { DateUtils } from 'react-day-picker'
import 'react-day-picker/lib/style.css'
import './IntakeDatePicker.scss'
import { getDaysArray } from '../utils'

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
    const { from, to } = this.props.stayDates
    // const fromTo = { from, to }
    const highlighted = {
      highlighted: getDaysArray(from, to),
    }

    return {
      modifiers: highlighted,
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

  handleResetClick() {
    this.setState(this.getInitialState())
    this.props.onIntakeDatesChange(this.getInitialState())
  }

  render() {
    return (
      <div className="RangeExample">
        <DayPicker
          className="Selectable"
          numberOfMonths={this.props.numberOfMonths}
          showOutsideDays={this.props.showOutsideDays}
          canChangeMonth={this.props.canChangeMonth}
          selectedDays={this.state.selectedDays}
          modifiers={this.state.modifiers}
          onDayClick={this.handleDayClick}
        />
      </div>
    )
  }
}
