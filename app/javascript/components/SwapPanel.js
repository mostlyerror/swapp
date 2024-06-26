import React from 'react'
import axios from 'axios'

const VoucherSupplyItem = (props) => (
  <li className="flex flex-1 justify-between items-center">
    <p className="tabular-nums font-semibold">{props.numVouchers}</p>
    <p className="">
      <span className="font-semibold">{props.hotel.name}{' '}</span>
      {props.hotel.pet_friendly && (
        <span className="text-xs bg-yellow-200 px-1 py-1 rounded-md">
          dogs ok
        </span>
      )}
      {
        `${props.hotel.address.street}, ${props.hotel.address.city}, ${props.hotel.address.state} ${props.hotel.address.zip}`
      }
    </p>
  </li>
)

const VoucherSupply = (props) => {
  return (
    <ul className="px-6 py-4 flex flex-1 flex-col gap-1 border-t-2 border-indigo-300">
      {Object.entries(props.vouchers_remaining_today).map((entry, idx) => {
        const hotelId = entry[0]
        const numVouchers = entry[1]
        const hotel = props.hotel_map[hotelId]

        return (
          <VoucherSupplyItem
            key={idx}
            numVouchers={numVouchers}
            hotel={hotel}
          />
        )
      })}
    </ul>
  )
}

class SwapPanel extends React.Component {
  state = { isOpen: this.props.current_user.show_swap_panel }

  handleToggle = (event) => {
    const userId = this.props.current_user.id
    const userSettingsURL = `/users/${userId}/settings`

    axios.put(userSettingsURL, { show_swap_panel: !this.state.isOpen })

    this.setState((prevState) => ({ isOpen: !prevState.isOpen }))
  }

  render() {
    return (
      <div className="text-sm sm:text-lg md:text-xl">
        <div className="px-6 py-3 flex justify-between items-center">
          <p className="font-semibold tabular-nums">
            {this.props.num_vouchers_remaining_today} vouchers left today
          </p>
          <button
            onClick={this.handleToggle}
            type="button"
            className="underline text-indigo-900"
          >
            {this.state.isOpen ? '- hide per hotel' : '+ view per hotel'}
          </button>
        </div>
        {this.state.isOpen && <VoucherSupply {...this.props} />}
      </div>
    )
  }
}

export default SwapPanel
