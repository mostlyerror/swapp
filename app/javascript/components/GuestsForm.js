import React, { Component } from 'react'
import { Dialog, Transition } from '@headlessui/react'
import Autocomplete from 'react-autocomplete'
import axios from 'axios'
import _ from 'lodash'
import { FaPlusCircle, FaMinusCircle } from 'react-icons/fa'
import ReactModal from 'react-modal'

const NULL_DOB_PLACEHOLDER_VALUE = '1600-01-01'

class GuestsForm extends Component {
  state = {
    clients: [],
    selected: [],
    val: '',
    newGuestFirstName: '',
    newGuestLastName: '',
    newGuestDateOfBirth: '',
    errors: [],
    showModal: false,
  }

  fetchClients = _.debounce((term) => {
    const clientsURL = `/clients/search.json?q=${term}`
    axios.get(clientsURL).then((response) => {
      this.setState({
        clients: response.data.filter((client, _idx) => {
          return client.id !== this.props.client.id
        }),
      })
    })
  }, 300)

  handleChange = (event, val) => {
    this.setState({ val: val })
    if (val === '' || val.length < 2) {
      return
    }
    this.fetchClients(val)
  }

  isItemSelectable = (item) => !item.red_flag

  handleSelect = (name, client) => {
    this.setState((prevState) => {
      return {
        val: '',
        clients: [],
        selected: _.uniqBy([...prevState.selected, client], 'id'),
      }
    })
  }

  removeGuest = (guest) => {
    this.setState((prevState) => ({
      selected: prevState.selected.filter((val, idx, arr) => {
        return val !== guest
      }),
    }))
  }

  renderClientName = (state, val) => {
    return state.name.toLowerCase().indexOf(val.toLowerCase()) !== -1
  }

  renderInput = (props) => {
    return (
      <div className="relative">
        <input
          maxLength={24}
          {...props}
          className="w-full p-2 text-base sm:text-lg md:text-xl border border-gray-300 rounded"
          placeholder="search for a guest"
        />
        <Transition
          appear={true}
          show={this.state.val.length > 2}
          enter="transition-opacity duration-200"
          enterFrom="opacity-0"
          enterTo="opacity-100"
          leave="transition-opacity duration-150"
          leaveFrom="opacity-100"
          leaveTo="opacity-0"
        >
          <button
            type="button"
            className="px-3 py-1 bg-indigo-600 absolute inset-y-1 right-1
            text-white text-base sm:text-lg md:text-xl rounded"
            onClick={this.openModal}
          >
            create
          </button>
        </Transition>
      </div>
    )
  }

  renderMenu = (item) => <div className="dropdown">{item}</div>

  renderItem = (item, isHighlighted) => (
    <div
      key={item.id}
      id={`add_guest_${item.id}`}
      className={`item ${
        isHighlighted ? 'selected-item' : ''
      } mt-4 grid grid-cols-11 space-evenly gap-4`}
    >
      <div
        className={`${
          item.red_flag ? 'text-gray-300 font-normal' : 'font-semibold'
        } col-span-5`}
      >
        {`${item.first_name} ${item.last_name}`}
      </div>
      <div
        className={`${
          item.red_flag ? 'text-gray-300 font-normal' : 'font-semibold'
        } col-span-5`}
      >
        {(item.date_of_birth !== NULL_DOB_PLACEHOLDER_VALUE &&
          item.date_of_birth) ||
          '--'}
      </div>
      <div className="text-right">
        {item.red_flag ? (
          '🚩'
        ) : (
          <button type="button">
            <FaPlusCircle className="text-indigo-500" />
          </button>
        )}
      </div>
    </div>
  )

  openModal = () => {
    this.setState({ showModal: true })
  }

  cancelModal = () => {
    this.setState({
      showModal: false,
      newGuestFirstName: '',
      newGuestLastName: '',
      newGuestDateOfBirth: '',
    })
  }

  closeModal = () => {
    this.setState({
      showModal: false,
      val: '',
      clients: [],
      newGuestFirstName: '',
      newGuestLastName: '',
      newGuestDateOfBirth: '',
      errors: [],
    })
  }

  createClient = (client) => {
    const clientsURL = `/clients`
    const csrfToken = document
      .querySelector('[name="csrf-token"]')
      .getAttribute('content')
    return axios.post(clientsURL, client, {
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken,
      },
    })
  }

  createGuest = () => {
    const newGuest = {
      first_name: this.state.newGuestFirstName,
      last_name: this.state.newGuestLastName,
      date_of_birth: this.state.newGuestDateOfBirth,
    }

    this.createClient(newGuest)
      .then((response) => {
        const guest = _.pick(response.data, [
          'id',
          'first_name',
          'last_name',
          'date_of_birth',
          'red_flag',
        ])

        this.setState((prevState) => {
          return {
            selected: [...prevState.selected, guest],
            errors: [],
          }
        })
        this.closeModal()
      })
      .catch((err) => {
        this.setState({
          errors: err.response.data,
        })
      })
  }

  addPriorGuests = () => {
    const priorGuests = this.props.prior_guests
      .map((guest, _idx) => {
        return _.pick(guest, [
          'id',
          'first_name',
          'last_name',
          'date_of_birth',
          'red_flag',
        ])
      })
      .filter((guest, _idx) => {
        return !guest.red_flag
      })
    this.setState((prevState) => {
      return {
        selected: [...prevState.selected, ...priorGuests],
      }
    })
  }

  render() {
    return (
      <div>
        <div id="guests">
          {this.state.selected.length === 0 &&
            this.props.prior_guests.length > 0 && (
              <div className="mt-4 sm:mt-6 md:mt-8">
                <p className="text-base sm:text-lg md:text-xl leading-loose">
                  <span className="inline md:block md:text-center">
                    {this.props.client.first_name} has had guests previously.
                  </span>
                  <span className="block md:text-center">
                    <button
                      type="button"
                      onClick={this.addPriorGuests}
                      class="px-2 py-1 bg-white hover:bg-gray-50 rounded shadow
                      border border-indigo-600 focus:outline-none focus:ring-2
                      focus:ring-offset-2 focus:ring-indigo-500 text-base sm:text-lg md:text-xl
                      transition-transform ease-in-out duration-1000 transform translate-x-full
                      "
                    >
                      add prior guests
                    </button>{' '}
                    before searching.
                  </span>
                </p>
              </div>
            )}

          {this.state.selected.length > 0 && (
            <div className="my-4 sm:my-6 md:my-8">
              <div className="grid grid-cols-11 space-evenly gap-4">
                <div className="col-span-5 font-semibold">Name</div>
                <div className="col-span-5 font-semibold">DOB</div>
                <div className="text-right"></div>
              </div>
              {this.state.selected.map((guest, idx) => (
                <div key={idx} className="grid grid-cols-11 space-evenly gap-4">
                  <input
                    className="hidden"
                    type="hidden"
                    name={`voucher[guest_ids][]`}
                    value={guest.id}
                  />
                  <div className="col-span-5">{`${guest.first_name} ${guest.last_name}`}</div>
                  <div className="col-span-5 tabular-nums">
                    {(guest.date_of_birth !== NULL_DOB_PLACEHOLDER_VALUE &&
                      guest.date_of_birth) ||
                      '--'}
                  </div>
                  <div
                    className="text-right"
                    onClick={() => this.removeGuest(guest)}
                  >
                    <button type="button">
                      <FaMinusCircle className="text-red-500" />
                    </button>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>

        <Autocomplete
          value={this.state.val}
          items={this.state.clients}
          getItemValue={(item) => `${item.first_name} ${item.last_name}`}
          inputProps={{
            id: 'guest_autocomplete',
            className: 'mt-6 p-1 w-full border border-gray-300 rounded',
            autoComplete: 'false',
            placeholder: 'Search for a guest',
          }}
          wrapperProps={{ className: 'w-full' }}
          shouldItemRender={this.renderClientName}
          renderInput={this.renderInput}
          renderMenu={this.renderMenu}
          renderItem={this.renderItem}
          onChange={this.handleChange}
          onSelect={this.handleSelect}
          isItemSelectable={this.isItemSelectable}
        />

        <Dialog
          open={this.state.showModal}
          onClose={this.cancelModal}
          className="fixed z-10 inset-0 overflow-y-auto"
        >
          <div className="p-2 sm:p-1 flex items-center justify-center min-h-screen">
            <Dialog.Overlay className="fixed inset-0 bg-black opacity-40" />

            <div className="p-2 sm:p-4 md:p-6 z-10 bg-white rounded max-w-lg mx-auto">
              <Dialog.Title className="text-lg sm:text-xl md:text-2xl font-bold">
                Create New Guest
              </Dialog.Title>
              <Dialog.Description className="text-base sm:text-lg md:text-xl text-gray-700"></Dialog.Description>

              {this.state.errors.length > 0 && (
                <div className="my-2 sm:my-4 md:my-6 rounded-lg bg-red-50 p-2">
                  <div className="flex">
                    <div className="flex-shrink-0">
                      <svg
                        className="h-5 w-5 sm:h-6 sm:w-6 md:h-8 md:w-8 text-red-400"
                        xmlns="http://www.w3.org/2000/svg"
                        viewBox="0 0 20 20"
                        fill="currentColor"
                        ariaHidden="true"
                      >
                        <path
                          fillRule="evenodd"
                          d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
                          clipRule="evenodd"
                        />
                      </svg>
                    </div>
                    <div className="ml-2 sm:ml-3 md:ml-4">
                      <h3 className="text-sm sm:text-base md:text-lg font-medium text-red-800">
                        There were errors with your submission
                      </h3>
                      <div className="mt-2 ml-2 sm:ml-3 md:ml-4 text-sm sm:text-base md:text-lg text-red-700">
                        <ul className="list-disc space-y-1 md:space-y-2">
                          {this.state.errors.map((error, idx) => {
                            return <li className="">{error}</li>
                          })}
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
              )}

              <div className="mt-2 sm:mt-4 md:mt-6 flex flex-col space-between gap-2 sm:gap-4 md:gap-6">
                <div>
                  <label className="block leading-snug text-base sm:text-lg md:text-xl font-semibold">
                    First Name
                  </label>
                  <input
                    type="text"
                    maxLength={24}
                    className="w-full rounded p-2 sm:p-3 md:p-4 text-base sm:text-lg md:text-xl border border-gray-300"
                    value={this.state.newGuestFirstName}
                    onChange={(event) => {
                      this.setState((prevState) => {
                        return {
                          ...prevState,
                          newGuestFirstName: event.target.value,
                        }
                      })
                    }}
                  />
                </div>
                <div>
                  <label className="block leading-snug text-base sm:text-lg md:text-xl font-semibold">
                    Last Name
                  </label>
                  <input
                    type="text"
                    maxLength={24}
                    className="w-full rounded p-2 sm:p-3 md:p-4 text-base sm:text-lg md:text-xl border border-gray-300"
                    value={this.state.newGuestLastName}
                    onChange={(event) => {
                      this.setState((prevState) => {
                        return {
                          ...prevState,
                          newGuestLastName: event.target.value,
                        }
                      })
                    }}
                  />
                </div>
                <div>
                  <label className="block leading-snug text-base sm:text-lg md:text-xl font-semibold">
                    Date of Birth
                  </label>
                  <input
                    type="date"
                    className="w-full rounded p-2 sm:p-3 md:p-4 text-base sm:text-lg md:text-xl border border-gray-300"
                    value={this.state.newGuestDateOfBirth}
                    onChange={(event) => {
                      this.setState((prevState) => {
                        return {
                          ...prevState,
                          newGuestDateOfBirth: event.target.value,
                        }
                      })
                    }}
                  />
                </div>
              </div>
              <div className="mt-4 sm:mt-6 md:mt-8 flex items-center gap-2 sm:gap-3 md:gap-4">
                <button
                  className="flex-1 text-base text-center px-4 py-2 border
                  border-gray-300 shadow-sm text-xs sm:text-base md:text-lg font-medium rounded
                  text-gray-700 bg-white hover:bg-gray-50 focus:outline-none
                  focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                  onClick={this.cancelModal}
                >
                  Cancel
                </button>

                <button
                  className="flex-1 text-base text-center px-4 py-2 border
                  border-gray-300 shadow-sm text-xs sm:text-base md:text-lg font-medium rounded
                  text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none
                  focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                  onClick={this.createGuest}
                >
                  Create
                </button>
              </div>
            </div>
          </div>
        </Dialog>
      </div>
    )
  }
}

export default GuestsForm
