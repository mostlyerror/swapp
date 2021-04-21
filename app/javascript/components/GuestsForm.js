import React, { Component } from "react";
import Autocomplete from "react-autocomplete";
import axios from "axios";
import _ from "lodash";
import { FaPlusCircle, FaMinusCircle } from "react-icons/fa";
import ReactModal from "react-modal";

class GuestsForm extends Component {
  state = {
    clients: [],
    selected: [],
    val: "",
    newGuestFirstName: "",
    newGuestLastName: "",
    newGuestDateOfBirth: "",
  };

  fetchClients = _.debounce((term) => {
    const clientsURL = `/clients/search.json?q=${term}`;
    axios.get(clientsURL).then((response) => {
      this.setState({ clients: response.data });
    });
  }, 300);

  handleChange = (event, val) => {
    this.setState({ val: val });
    if (val === "" || val.length < 2) {
      return;
    }
    this.fetchClients(val);
  };

  isItemSelectable = (item) => {
    return !item.red_flag;
  };

  handleSelect = (name, client) => {
    this.setState((prevState) => {
      return {
        val: "",
        selected: _.uniqWith([...prevState.selected, client], _.isEqual),
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
        {item.name}
      </div>
      <div
        className={`${
          item.red_flag ? "text-gray-300 font-normal" : "font-semibold"
        } col-span-5`}
      >
        {item.date_of_birth}
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
      newGuestFirstName: "",
      newGuestLastName: "",
      newGuestDateOfBirth: "",
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
      name: `${this.state.newGuestFirstName} ${this.state.newGuestLastName}`,
      first_name: this.state.newGuestFirstName,
      last_name: this.state.newGuestLastName,
      date_of_birth: this.state.newGuestDateOfBirth,
    };

    this.createClient(newGuest).then((response) => {
      const guest = _.pick(response.data, [
        "id",
        "first_name",
        "last_name",
        "date_of_birth",
        "red_flag",
      ]);
      guest.name = `${guest.first_name} ${guest.last_name}`;

      this.setState((prevState) => {
        return { selected: [...prevState.selected, guest] };
      });
      this.closeModal();
    });
  };

  render() {
    return (
      <div>
        <div id="guests">
          {this.state.selected.length > 0 && (
            <div>
              <div className="grid grid-cols-11 space-evenly gap-4 pt-12">
                <div className="col-span-5 font-semibold">Name</div>
                <div className="col-span-5 font-semibold">DOB</div>
                <div key="guests-list" className="text-right"></div>
              </div>
              {this.state.selected.map((item, idx) => (
                <div
                  key={idx}
                  className="grid grid-cols-11 space-evenly gap-4 pt-12"
                >
                  <div className="col-span-5">{item.name}</div>
                  <div className="col-span-5 tabular-nums">
                    {item.date_of_birth || "--"}
                  </div>
                  <div
                    className="text-right"
                    onClick={() => this.removeGuest(item)}
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
          getItemValue={(item) => item.name}
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
          className="absolute inset-y-40 inset-x-12 border border-gray-300 bg-white opacity-100 overflow-auto rounded-lg py-20 px-12"
          contentLabel="Create Guest Modal"
        >
          <h3 className="text-5xl font-bold">Create New Guest</h3>
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
          <div className="mt-16 flex justify-end items-center gap-6">
            <button
              className="text-4xl inline-flex items-center px-6 py-4 border border-gray-300
              shadow-sm text-xs font-medium rounded text-gray-700 bg-white
              hover:bg-gray-50 focus:outline-none focus:ring-2
              focus:ring-offset-2 focus:ring-indigo-500"
              onClick={this.cancelModal}
            >
              cancel
            </button>
            <button
              className="text-4xl btn btn-indigo"
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
