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
      <div>
        <div id="guests">
          {this.state.selected.length > 0 && (
            <div className="grid grid-cols-11 space-evenly gap-4 pt-12">
              <div className="col-span-5 font-semibold">Name</div>
              <div className="col-span-5 font-semibold">DOB</div>
              <div key="guests-list" className="text-right"></div>
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
                    <button type="button">
                      <svg
                        className="w-10 h-10 text-red-500"
                        viewBox="0 0 72.434 72.44"
                        fill="currentColor"
                      >
                        <path
                          d="M36.22,0C16.212,0,0,16.216,0,36.227c0,19.999,16.212,36.214,36.22,36.214
	c20.011,0,36.214-16.215,36.214-36.214C72.434,16.215,56.231,0,36.22,0z M52.058,46.82c1.379,1.424,0.953,4.078-0.959,5.932
	c-1.911,1.854-4.577,2.209-5.959,0.785l-9.027-9.295l-9.298,9.027c-1.421,1.379-4.075,0.947-5.929-0.961s-2.206-4.574-0.785-5.956
	l9.298-9.027l-9.027-9.298c-1.379-1.421-0.946-4.078,0.962-5.932c1.905-1.851,4.577-2.204,5.953-0.785l9.027,9.297l9.301-9.023
	c1.424-1.382,4.078-0.95,5.929,0.958c1.857,1.908,2.206,4.577,0.785,5.959l-9.295,9.024L52.058,46.82z"
                        />
                      </svg>
                    </button>
                  </div>
                </>
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
                  <button type="button">
                    <svg
                      className="w-10 h-10 text-indigo-500"
                      viewBox="0 0 20 20"
                      version="1.1"
                    >
                      <g
                        id="Icons"
                        stroke-width="1"
                        fill="none"
                        fill-rule="evenodd"
                      >
                        <g
                          id="Outlined"
                          transform="translate(-850.000000, -1484.000000)"
                        >
                          <g
                            id="Content"
                            transform="translate(100.000000, 1428.000000)"
                          >
                            <g
                              id="Outlined-/-Content-/-add_circle"
                              transform="translate(748.000000, 54.000000)"
                            >
                              <g>
                                <polygon
                                  id="Path"
                                  points="0 0 24 0 24 24 0 24"
                                ></polygon>
                                <path
                                  d="M12,2 C6.48,2 2,6.48 2,12 C2,17.52 6.48,22 12,22 C17.52,22 22,17.52 22,12 C22,6.48 17.52,2 12,2 Z M17,13 L13,13 L13,17 L11,17 L11,13 L7,13 L7,11 L11,11 L11,7 L13,7 L13,11 L17,11 L17,13 Z"
                                  fill="currentColor"
                                ></path>
                              </g>
                            </g>
                          </g>
                        </g>
                      </g>
                    </svg>
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
