import React from 'react'
import DayPicker, { DateUtils } from 'react-day-picker'
import 'react-day-picker/lib/style.css'
import './IntakeDatePicker.css'
import { getDaysArray } from '../utils'
import dayjs from 'dayjs'

export default class IntakeDatePicker extends React.Component {
  static defaultProps = {
    numberOfMonths: 2,
    canChangeMonth: false,
    showOutsideDays: true,
    selectedDays: [],
  }

  constructor(props) {
    super(props)
    this.handleDayClick = this.handleDayClick.bind(this)
    this.state = this.getInitialState()
  }

  getInitialState() {
    const { from, to } = this.props.stayDates
    const stayDays = getDaysArray(from, to)

    const firstCalendarDay = new Date(dayjs().startOf('month'))
    const lastCalendarDay = new Date(
      dayjs()
        .month(new Date().getMonth() + (this.props.numberOfMonths - 1))
        .endOf('month')
    )
    const allCalendarDays = getDaysArray(firstCalendarDay, lastCalendarDay)
    const possibleIntakeDays = allCalendarDays.filter((date, idx) => {
      return (
        !DateUtils.isPastDay(date) &&
        DateUtils.isDayBefore(date, stayDays[stayDays.length - 1])
      )
    })

    const disabledDays = _.difference(allCalendarDays, possibleIntakeDays)

    const modifiers = {
      highlighted: getDaysArray(from, to),
      start: stayDays[0],
      end: stayDays[stayDays.length - 1],
    }

    return {
      modifiers,
      disabledDays,
      selectedDays: this.props.selectedDays,
    }
  }

  handleDayClick(day, { selected }) {
    if (DateUtils.isPastDay(day)) return false
    if (!DateUtils.isDayBefore(day, this.props.stayDates.to)) return false

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

  render() {
    return (
      <div>
        <DayPicker
          className="IntakeDayPicker tabular-nums"
          numberOfMonths={this.props.numberOfMonths}
          showOutsideDays={this.props.showOutsideDays}
          canChangeMonth={this.props.canChangeMonth}
          selectedDays={this.state.selectedDays}
          modifiers={this.state.modifiers}
          onDayClick={this.handleDayClick}
          onDayMouseEnter={this.handleDayMouseEnter}
          disabledDays={this.state.disabledDays}
        />
        {this.state.selectedDays.length > 0 && (
          <div className="mt-4 text-3xl tabular-nums">
            <span className="font-bold">Selected Intake Dates: </span>
            <br />
            {this.state.selectedDays
              .map((day) => day.toLocaleDateString())
              .join(', ')}
          </div>
        )}
      </div>
    )
  }
}
