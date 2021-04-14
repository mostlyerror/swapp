import React, { Component } from "react";
import Autocomplete from "react-autocomplete";
import axios from "axios";
import _ from "lodash";

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

  render() {
    return (
      <div className="">
        <h3 className="text-6xl leading-loose font-medium text-gray-900">
          Additional Guest(s)
          <p className="text-4xl text-indigo-800">
            some help text about the number of guests?
          </p>
        </h3>

        <div
          id="guests"
          className="mt-16 pb-8 grid grid-cols-11 space-evenly gap-4"
        >
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

        <Autocomplete
          value={this.state.val}
          items={this.state.clients}
          getItemValue={(item) => item.name}
          inputProps={{
            className: "border border-gray-350 rounded-lg p-8 w-full",
            autoComplete: "false",
          }}
          wrapperProps={{ className: "w-full" }}
          shouldItemRender={renderClientName}
          renderMenu={(item) => <div className="dropdown">{item}</div>}
          renderItem={(item, isHighlighted) => (
            <div
              key={item.id}
              className={`item ${
                isHighlighted ? "selected-item" : ""
              } mt-16 grid grid-cols-11 space-evenly gap-4`}
            >
              <div className="col-span-5 font-semibold">{item.name}</div>
              <div className="col-span-5 font-semibold">
                {item.date_of_birth}
              </div>
              <div className="text-right">
                {item.red_flag ? (
                  "🚩"
                ) : (
                  <button type="button" className="btn btn-indigo">
                    +
                  </button>
                )}
              </div>
            </div>
          )}
          onChange={this.handleChange}
          onSelect={this.handleSelect}
          isItemSelectable={this.isItemSelectable}
        />
      </div>
    );
  }
}

export default GuestsForm;
