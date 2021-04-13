import React from "react";
import Downshift from "downshift";
import axios from "axios";

class ClientAutocomplete extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      clients: [],
    };
    this.fetchClients = this.fetchClients.bind(this);
    this.inputOnChange = this.inputOnChange.bind(this);
  }

  inputOnChange(event) {
    // TODO minimum input size = 2
    // debounce so we're doing less xhr requests?
    if (!event.target.value) {
      return;
    }
    this.fetchClients(event.target.value);
  }

  downshiftOnChange(selectedClient) {
    alert(`selected client is ${selectedClient.name}`);
  }

  fetchClients(client) {
    const clientsURL = `/clients/search.json?q=${client}`;
    axios.get(clientsURL).then((response) => {
      this.setState({ clients: response.data });
    });
  }

  render() {
    return (
      <Downshift
        onChange={this.downshiftOnChange}
        itemToString={(item) => (item ? item.name : "")}
      >
        {({
          selectedItem,
          getInputProps,
          getItemProps,
          highlightedIndex,
          isOpen,
          inputValue,
          getLabelProps,
        }) => (
          <div>
            <input
              {...getInputProps({
                placeholder: "Search guest name..",
                onChange: this.inputOnChange,
              })}
            />
            {isOpen ? (
              <div className="downshift-dropdown">
                {this.state.clients
                  .filter(
                    (item) =>
                      !inputValue ||
                      item.name.toLowerCase().includes(inputValue.toLowerCase())
                  )
                  .slice(0, 10)
                  .map((item, index) => (
                    <div
                      className="dropdown-item"
                      {...getItemProps({ key: index, index, item })}
                      style={{
                        backgroundColor:
                          highlightedIndex === index ? "lightgray" : "white",
                        fontWeight: selectedItem === item ? "bold" : "normal",
                      }}
                    >
                      {item.name}
                    </div>
                  ))}
              </div>
            ) : null}
          </div>
        )}
      </Downshift>
    );
  }
}

class GuestsForm extends React.Component {
  render() {
    return (
      <div>
        <h3 className="text-6xl leading-loose font-medium text-gray-900">
          Additional Guest(s)
          <p className="text-4xl text-indigo-800">
            some help text about the number of guests?
          </p>
        </h3>
        <div id="guests_container">
          <div id="guests" className="mt-16"></div>
          <ClientAutocomplete />
        </div>
      </div>
    );
  }
}

export default GuestsForm;
