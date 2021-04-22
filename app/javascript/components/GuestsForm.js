import React, { Component } from "react";
import Autocomplete from "react-autocomplete";
import axios from "axios";
import _ from "lodash";
import { FaPlusCircle, FaMinusCircle } from "react-icons/fa";
import ReactModal from "react-modal";

const NULL_DOB_PLACEHOLDER_VALUE = "1600-01-01";

class GuestsForm extends Component {
  state = {
    clients: [],
    selected: [],
    val: "",
    newGuestFirstName: "",
    newGuestLastName: "",
    newGuestDateOfBirth: "",
    errors: [],
  };

  fetchClients = _.debounce((term) => {
    const clientsURL = `/clients/search.json?q=${term}`;
    axios.get(clientsURL).then((response) => {
      this.setState({
        clients: response.data.filter((client, _idx) => {
          return client.id !== this.props.client.id;
        }),
      });
    });
  }, 300);

  handleChange = (event, val) => {
    this.setState({ val: val });
    if (val === "" || val.length < 2) {
      return;
    }
    this.fetchClients(val);
  };

  isItemSelectable = (item) => !item.red_flag;

  handleSelect = (name, client) => {
    this.setState((prevState) => {
      return {
        val: "",
        clients: [],
        selected: _.uniqBy([...prevState.selected, client], "id"),
      };
    });
  };

  removeGuest = (guest) => {
    this.setState((prevState) => ({
      selected: prevState.selected.filter((val, idx, arr) => {
        return val !== guest;
      }),
    }));
  };

  renderClientName = (state, val) => {
    return state.name.toLowerCase().indexOf(val.toLowerCase()) !== -1;
  };

  renderInput = (props) => {
    return (
      <div className="relative">
        <input maxLength={24} {...props} />
        {this.state.val.length > 2 && (
          <button
            type="button"
            className="btn btn-indigo absolute top-18 right-6 text-4xl"
            onClick={this.openModal}
          >
            create
          </button>
        )}
      </div>
    );
  };

  renderMenu = (item) => <div className="dropdown">{item}</div>;

  renderItem = (item, isHighlighted) => (
    <div
      key={item.id}
      className={`item ${
        isHighlighted ? "selected-item" : ""
      } mt-16 grid grid-cols-11 space-evenly gap-4`}
    >
      <div
        className={`${
          item.red_flag ? "text-gray-300 font-normal" : "font-semibold"
        } col-span-5`}
      >
        {`${item.first_name} ${item.last_name}`}
      </div>
      <div
        className={`${
          item.red_flag ? "text-gray-300 font-normal" : "font-semibold"
        } col-span-5`}
      >
        {(item.date_of_birth !== NULL_DOB_PLACEHOLDER_VALUE &&
          item.date_of_birth) ||
          "--"}
      </div>
      <div className="text-right">
        {item.red_flag ? (
          "🚩"
        ) : (
          <button type="button">
            <FaPlusCircle className="text-indigo-500" />
          </button>
        )}
      </div>
    </div>
  );

  openModal = () => {
    this.setState({ showModal: true });
  };

  cancelModal = () => {
    this.setState({
      showModal: false,
      newGuestFirstName: "",
      newGuestLastName: "",
      newGuestDateOfBirth: "",
    });
  };

  closeModal = () => {
    this.setState({
      showModal: false,
      val: "",
      clients: [],
      newGuestFirstName: "",
      newGuestLastName: "",
      newGuestDateOfBirth: "",
      errors: [],
    });
  };

  createClient = (client) => {
    const clientsURL = `/clients`;
    const csrfToken = document
      .querySelector('[name="csrf-token"]')
      .getAttribute("content");
    return axios.post(clientsURL, client, {
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
      },
    });
  };

  createGuest = () => {
    const newGuest = {
      first_name: this.state.newGuestFirstName,
      last_name: this.state.newGuestLastName,
      date_of_birth: this.state.newGuestDateOfBirth,
    };

    this.createClient(newGuest)
      .then((response) => {
        const guest = _.pick(response.data, [
          "id",
          "first_name",
          "last_name",
          "date_of_birth",
          "red_flag",
        ]);

        this.setState((prevState) => {
          return {
            selected: [...prevState.selected, guest],
            errors: [],
          };
        });
        this.closeModal();
      })
      .catch((err) => {
        this.setState({
          errors: [err.response.data],
        });
      });
  };

  addPriorGuests = () => {
    const priorGuests = this.props.prior_guests.map((guest, _idx) => {
      return _.pick(guest, [
        "id",
        "first_name",
        "last_name",
        "date_of_birth",
        "red_flag",
      ]);
    });
    this.setState((prevState) => {
      return {
        selected: [...prevState.selected, ...priorGuests],
      };
    });
  };

  render() {
    return (
      <div>
        <div id="guests">
          {this.state.selected.length === 0 && (
            <div className="mt-8">
              This client has had guests previously. You can add these guests
              before searching.
              <button
                type="button"
                onClick={this.addPriorGuests}
                className="flex-1 text-4xl text-center px-6 py-4 border border-gray-300
              shadow-sm text-xs font-medium rounded text-gray-700 bg-white
              hover:bg-gray-50 focus:outline-none focus:ring-2
              focus:ring-offset-2 focus:ring-indigo-500"
              >
                add prior guests
              </button>
            </div>
          )}

          {this.state.selected.length > 0 && (
            <div>
              <div className="grid grid-cols-11 space-evenly gap-4 pt-12">
                <div className="col-span-5 font-semibold">Name</div>
                <div className="col-span-5 font-semibold">DOB</div>
                <div key="guests-list" className="text-right"></div>
              </div>
              {this.state.selected.map((guest, idx) => (
                <div
                  key={idx}
                  className="grid grid-cols-11 space-evenly gap-4 pt-12"
                >
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
                      "--"}
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
            className: "border border-gray-350 rounded-lg mt-12 p-8 w-full",
            autoComplete: "false",
            placeholder: "Search for a guest",
          }}
          wrapperProps={{ className: "w-full" }}
          shouldItemRender={this.renderClientName}
          renderInput={this.renderInput}
          renderMenu={this.renderMenu}
          renderItem={this.renderItem}
          onChange={this.handleChange}
          onSelect={this.handleSelect}
          isItemSelectable={this.isItemSelectable}
        />

        <ReactModal
          ariaHideApp={false}
          isOpen={this.state.showModal}
          onRequestClose={this.closeModal}
          transparent={true}
          overlayClassName="fixed top-0 left-0 right-0 bottom-0 bg-black bg-opacity-75 z-20"
          className="absolute inset-y-1/4 sm:inset-y-1/8 inset-x-8 border border-gray-300 bg-white opacity-100 overflow-auto rounded-lg py-20 px-12"
          contentLabel="Create Guest Modal"
        >
          <h3 className="text-5xl font-bold">Create New Guest</h3>

          {this.state.errors.length > 0 && (
            <div className="mt-12 rounded-lg bg-red-50 p-4">
              <div className="flex justify-center">
                <div className="flex-shrink-0">
                  <svg
                    className="h-10 w-10 text-red-400"
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
                <div className="ml-3">
                  <h3 className="text-4xl font-medium text-red-800">
                    There were errors with your submission
                  </h3>
                  <div className="mt-2 text-4xl text-red-700">
                    <ul className="list-disc pl-5 space-y-1">
                      {this.state.errors.map((error, idx) => {
                        return <li>{error}</li>;
                      })}
                    </ul>
                  </div>
                </div>
              </div>
            </div>
          )}

          <div className="mt-12 flex flex-col space-between gap-12">
            <div>
              <label className="block leading-snug text-4xl font-semibold">
                First Name
              </label>
              <input
                type="text"
                maxLength={24}
                className="w-full rounded-lg p-8 text-4xl"
                value={this.state.newGuestFirstName}
                onChange={(event) => {
                  this.setState((prevState) => {
                    return {
                      ...prevState,
                      newGuestFirstName: event.target.value,
                    };
                  });
                }}
              />
            </div>
            <div>
              <label className="block leading-snug text-4xl font-semibold">
                Last Name
              </label>
              <input
                type="text"
                maxLength={24}
                className="w-full rounded-lg p-8 text-4xl"
                value={this.state.newGuestLastName}
                onChange={(event) => {
                  this.setState((prevState) => {
                    return {
                      ...prevState,
                      newGuestLastName: event.target.value,
                    };
                  });
                }}
              />
            </div>
            <div>
              <label className="block leading-snug text-4xl font-semibold">
                Date of Birth
              </label>
              <input
                type="date"
                className="w-full rounded-lg p-8 text-4xl"
                value={this.state.newGuestDateOfBirth}
                onChange={(event) => {
                  this.setState((prevState) => {
                    return {
                      ...prevState,
                      newGuestDateOfBirth: event.target.value,
                    };
                  });
                }}
              />
            </div>
          </div>
          <div className="mt-16 flex items-center gap-6">
            <button
              className="flex-1 text-4xl text-center px-6 py-4 border border-gray-300
              shadow-sm text-xs font-medium rounded text-gray-700 bg-white
              hover:bg-gray-50 focus:outline-none focus:ring-2
              focus:ring-offset-2 focus:ring-indigo-500"
              onClick={this.cancelModal}
            >
              cancel
            </button>
            <button
              className="flex-1 text-4xl text-center btn btn-indigo"
              onClick={this.createGuest}
            >
              create
            </button>
          </div>
        </ReactModal>
      </div>
    );
  }
}

export default GuestsForm;
