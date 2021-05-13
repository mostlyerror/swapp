import React, { Component } from "react";
import { FiEdit } from "react-icons/fi";
import { ImCancelCircle } from "react-icons/im";
import { MdSystemUpdateAlt } from "react-icons/md";
import { classNames } from "./utils";

class ClientEditForm extends Component {
  state = {
    isEditing: false,
    client: this.props.client,
  };

  handleChange = (event) => {
    this.setState((prevState) => {
      let client = prevState.client;
      if (event.target.name == "race") {
        let races = new Set(c.race.split(","));

        event.target.checked
          ? races.add(event.target.value)
          : races.delete(event.target.value);

        client.race = Array.from(races)
          .filter((e) => String(e).trim())
          .sort()
          .join(",");
        return { currentFamilyMember: f };
      }

      client[event.target.name] = event.target.value;
      return { client };
    });
  };

  render() {
    return (
      <div>
        <div className="grid grid-cols-1 items-center">
          <label className="font-semibold tracking-wide">First Name:</label>
          <input
            type="text"
            readOnly={!this.state.isEditing}
            className={classNames("p-2 text-sm border border-gray-100 rounded")}
            value={this.props.client.first_name}
            name={"first_name"}
            onChange={this.handleChange}
          />
          <label className="font-semibold tracking-wide">Last Name:</label>
          <input
            type="text"
            readOnly={!this.state.isEditing}
            className="p-2 text-sm border-1 border-gray-100 rounded pointer-events-none"
            value={this.props.client.last_name}
          />
          <label className="font-semibold tracking-wide">Date of birth:</label>
          <input
            type="date"
            readOnly={!this.state.isEditing}
            className="p-2 text-sm border border-gray-100 rounded pointer-events-none"
            value={this.props.client.date_of_birth}
          />
          <label className="font-semibold tracking-wide">
            Gender Identity:
          </label>{" "}
          <input
            type="text"
            readOnly={!this.state.isEditing}
            className="p-2 text-sm border border-gray-100 rounded pointer-events-none"
            value={this.props.client.gender}
          />
          <label className="font-semibold tracking-wide">Race:</label>
          <input
            type="text"
            readOnly={!this.state.isEditing}
            className="p-2 text-sm border border-gray-100 rounded pointer-events-none"
            value={this.props.client.race.join(", ")}
          />
          <label className="font-semibold tracking-wide">Ethnicity:</label>
          <input
            type="text"
            readOnly={!this.state.isEditing}
            className="p-2 text-sm border border-gray-100 rounded pointer-events-none"
            value={this.props.client.ethnicity}
          />
          <div className="flex items-center">
            {!this.state.isEditing && (
              <button
                type="button"
                className="flex items-center space-x-2 px-2 py-1 bg-white hover:bg-gray-50 rounded shadow border border-indigo-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                onClick={() => {
                  this.setState({ isEditing: true });
                }}
              >
                <FiEdit />
                <span>Edit Client Details</span>
              </button>
            )}
            {this.state.isEditing && (
              <div className="w-full flex items-center">
                <button
                  type="button"
                  className="flex flex-1 items-center space-x-2 px-2 py-1 bg-white hover:bg-gray-50 rounded shadow border border-indigo-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                  onClick={() => {
                    this.setState({ isEditing: false });
                  }}
                >
                  <ImCancelCircle />
                  <span>Cancel</span>
                </button>
                <button
                  type="button"
                  className="flex flex-1 items-center space-x-2 px-2 py-1 bg-white hover:bg-gray-50 rounded shadow border border-indigo-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                  onClick={() => {
                    this.setState({ isEditing: false });
                  }}
                >
                  <MdSystemUpdateAlt />
                  <span>Update</span>
                </button>
              </div>
            )}
          </div>
        </div>
      </div>
    );
  }
}
export default ClientEditForm;
