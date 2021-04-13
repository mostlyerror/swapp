import React, { Component } from "react";
import Autocomplete from "react-autocomplete";
import axios from "axios";

const renderClientName = (state, val) => {
  return state.name.toLowerCase().indexOf(val.toLowerCase()) !== -1;
};

class GuestsForm extends Component {
  state = { clients: [], selected: [], val: "" };

  render() {
    return (
      <div className="autocomplete-wrapper">
        <h3 className="text-6xl leading-loose font-medium text-gray-900">
          Additional Guest(s)
          <p className="text-4xl text-indigo-800">
            some help text about the number of guests?
          </p>
        </h3>
        <div id="guests_container">
          <div id="guests" className="mt-16">
            {this.state.selected.map((item, idx) => (
              <div>
                {item.name} - {item.date_of_birth}
              </div>
            ))}
          </div>

          <Autocomplete
            value={this.state.val}
            items={this.state.clients}
            getItemValue={(item) => item.name}
            shouldItemRender={renderClientName}
            renderMenu={(item) => <div className="dropdown">{item}</div>}
            renderItem={(item, isHighlighted) => (
              <div className={`item ${isHighlighted ? "selected-item" : ""}`}>
                {item.name} - {item.date_of_birth}
              </div>
            )}
            onChange={(event, val) => {
              const clientsURL = `/clients/search.json?q=${val}`;
              axios.get(clientsURL).then((response) => {
                this.setState({ clients: response.data, val: val });
              });
            }}
            onSelect={(name, client) => {
              this.setState((prevState) => ({
                selected: [...prevState.selected, client],
              }));
            }}
          />
        </div>
      </div>
    );
  }
}

export default GuestsForm;
