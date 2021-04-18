import React, { Component } from "react";
import Autocomplete from "react-autocomplete";
import axios from "axios";
import _ from "lodash";
import { FaPlusCircle, FaMinusCircle } from "react-icons/fa";

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

  renderClientName = (state, val) => {
    return state.name.toLowerCase().indexOf(val.toLowerCase()) !== -1;
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
                  <div className="col-span-5  tabular-nums">
                    {item.date_of_birth}
                  </div>
                  <div
                    className="text-right"
                    key={idx}
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
          renderMenu={this.renderMenu}
          renderItem={this.renderItem}
          onChange={this.handleChange}
          onSelect={this.handleSelect}
          isItemSelectable={this.isItemSelectable}
        />
      </div>
    );
  }
}

export default GuestsForm;
