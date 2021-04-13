import React, { Component } from "react";
import Autocomplete from "react-autocomplete";
import axios from "axios";

const renderClientName = (state, val) => {
  return state.name.toLowerCase().indexOf(val.toLowerCase()) !== -1;
};

class GuestsForm extends Component {
  state = { clients: [], selected: [], val: "" };

  handleChange = (event, val) => {
    if (val === "" || val.length < 2) {
      return this.setState({ val: val });
    }
    const clientsURL = `/clients/search.json?q=${val}`;
    axios.get(clientsURL).then((response) => {
      this.setState({ clients: response.data, val: val });
    });
  };

  handleSelect = (name, client) => {
    this.setState((prevState) => ({
      selected: [...prevState.selected, client],
      val: "",
    }));
  };

  removeGuest = (guest) => {
    this.setState((prevState) => ({
      selected: prevState.selected.filter((val, idx, arr) => {
        return val !== guest;
      }),
    }));
  };

  render() {
    return (
      <div className="">
        <h3 className="text-6xl leading-loose font-medium text-gray-900">
          Additional Guest(s)
          <p className="text-4xl text-indigo-800">
            some help text about the number of guests?
          </p>
        </h3>

        <div id="guests" className="mt-16 grid grid-cols-11 space-evenly gap-4">
          {this.state.selected.length > 0 && (
            <>
              <div className="col-span-5 font-semibold">Name</div>
              <div className="col-span-5 font-semibold">DOB</div>
              <div key="guests-list" className="text-right"></div>
            </>
          )}

          {this.state.selected.map((item, idx) => (
            <>
              <div className="col-span-5">{item.name}</div>
              <div className="col-span-5  tabular-nums">
                {item.date_of_birth}
              </div>
              <div
                className="text-right"
                key={idx}
                onClick={() => this.removeGuest(item)}
              >
                x
              </div>
            </>
          ))}
        </div>

        <div className="mt-8">
          <Autocomplete
            value={this.state.val}
            items={this.state.clients}
            getItemValue={(item) => item.name}
            inputProps={{
              className: "border border-gray-350 rounded-lg p-8 w-full",
              autocomplete: "false",
            }}
            wrapperProps={{ className: "w-full" }}
            shouldItemRender={renderClientName}
            renderMenu={(item) => <div className="dropdown">{item}</div>}
            renderItem={(item, isHighlighted) => (
              <div className={`item ${isHighlighted ? "selected-item" : ""}`}>
                {item.name} - {item.date_of_birth}
              </div>
            )}
            onChange={this.handleChange}
            onSelect={this.handleSelect}
          />
        </div>
      </div>
    );
  }
}

export default GuestsForm;
