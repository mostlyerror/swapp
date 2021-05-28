import React from 'react'

const VoucherSupplyItem = (props) => (
  <li className="flex flex-1 justify-between items-center">
    <p className="tabular-nums font-semibold">
      { props.numVouchers }
    </p>
    <p className="">
      { props.hotel.name }
      {" "}
      { props.hotel.pet_friendly && (
        <span className="text-xs bg-yellow-200 px-1 py-1 rounded-md">dogs ok</span>
      )}
    </p>
  </li>
)

const VoucherSupply = (props) => {
  return (
    <ul className="px-6 py-4 flex flex-1 flex-col gap-1 border-t-2 border-indigo-300" >
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
  state = { isOpen: this.props.isOpen }

  handleToggle = (event) => {
    this.setState((prevState) => {
      return {
        isOpen: !prevState.isOpen
      };
    });
  }

  render() {
    console.log(this.props);
    return (
      <div className="text-sm sm:text-lg md:text-xl" >
        <div className="px-6 py-3 flex justify-between items-center">
          <p className="font-semibold tabular-nums">
            { this.props.num_vouchers_remaining_today }
          </p>
          <button onClick={this.handleToggle} type="button" className="underline text-indigo-900">
            { this.state.isOpen ? "+ view per hotel" : "- hide per hotel" }
          </button>
        </div>
        { this.state.isOpen && <VoucherSupply {...this.props} /> }
      </div>
    )
  }
}

export default SwapPanel