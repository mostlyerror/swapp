import React, { Component } from "react";
import { BsTrash } from "react-icons/bs";
import { HiOutlineSaveAs } from "react-icons/hi";

class FamilyMemberForm extends Component {
  render() {
    let f = this.props.familyMember;
    return (
      <div className="flex flex-col bg-white rounded shadow">
        <div class="p-2">
          <h2 className="font-bold text-base sm:text-lg md:text-xl">
            New Family Member
          </h2>
        </div>
        <div className="p-2 sm:p-3 space-y-3 sm:space-y-4">
          <div>
            <label
              className="block text-base sm:text-lg md:text-xl"
              htmlFor={this.props.first_name.key}
            >
              {this.props.first_name.text}
            </label>
            <input
              type="text"
              name={this.props.first_name.key}
              className="w-full text-base sm:text-lg md:text-xl border border-gray-200 rounded-sm"
              onChange={this.props.handleChange}
              value={f.first_name}
              autoFocus
            />
          </div>
          <div>
            <label
              className="block text-base sm:text-lg md:text-xl"
              htmlFor={this.props.last_name.key}
            >
              {this.props.last_name.text}
            </label>
            <input
              type="text"
              name={this.props.last_name.key}
              className="w-full text-base sm:text-lg md:text-xl border border-gray-200 rounded-sm"
              onChange={this.props.handleChange}
              value={f.last_name}
            />
          </div>
          <div>
            <label
              className="block text-base sm:text-lg md:text-xl"
              htmlFor={this.props.relationship.key}
            >
              {this.props.relationship.text}
            </label>
            <input
              type="text"
              name={this.props.relationship.key}
              className="w-full text-base sm:text-lg md:text-xl border border-gray-200 rounded-sm"
              onChange={this.props.handleChange}
              value={f.relationship}
            />
          </div>
          <div>
            <label
              className="block text-base sm:text-lg md:text-xl"
              htmlFor={this.props.date_of_birth.key}
            >
              {this.props.date_of_birth.text}
            </label>
            <input
              type="date"
              name={this.props.date_of_birth.key}
              className="w-full text-base sm:text-lg md:text-xl border border-gray-200 rounded-sm"
              onChange={this.props.handleChange}
              value={f.date_of_birth}
            />
          </div>
          <div>
            <label
              className="block text-base sm:text-lg md:text-xl"
              htmlFor={this.props.gender.key}
            >
              {this.props.gender.text}
            </label>
            <select
              className="w-full text-base sm:text-lg md:text-xl border border-gray-200 rounded-sm"
              name={this.props.gender.key}
              onChange={this.props.handleChange}
              value={f.gender}
            >
              <option></option>
              {this.props.gender.choices.map((choice, idx) => (
                <option key={idx}>{choice}</option>
              ))}
            </select>
          </div>
          <div>
            <label
              className="block text-base sm:text-lg md:text-xl"
              htmlFor={this.props.race.key}
            >
              {this.props.race.text}
            </label>
            <ul className="p-1 space-y-1 sm:space-y-2 md:space-y-3">
              {this.props.race.choices.map((choice, idx) => (
                <li key={idx}>
                  <input
                    multiple
                    className="w-4 h-4 sm:w-5 sm:h-5 md:w-6 md:h-6 rounded text-indigo-600
                  border-gray-300 focus:border-indigo-500 focus:ring-indigo-200
                  focus:ring-offset-0 focus:ring-3"
                    type="checkbox"
                    name={this.props.race.key}
                    value={choice}
                    checked={f.race.includes(choice)}
                    id={choice}
                    onChange={this.props.handleChange}
                  />
                  <label
                    className="ml-2 sm:ml-3 md:ml-4 text-base sm:text-lg md:text-xl"
                    htmlFor={choice}
                  >
                    {choice}
                  </label>
                </li>
              ))}
            </ul>
          </div>
          <div className="mt-2 p-1 space-y-4">
            <div className="flex items-center justify-between">
              <label
                className="text-base sm:text-lg md:text-xl"
                htmlFor={this.props.ethnicity.key}
              >
                {this.props.ethnicity.text}
              </label>
              <div className="flex items-center space-x-8">
                <span className="inline-flex items-center">
                  <input
                    type="radio"
                    name={this.props.ethnicity.key}
                    onChange={this.props.handleChange}
                    value={true}
                    checked={f.ethnicity === "true"}
                  />
                  <label className="ml-1 md:ml-2 text-base sm:text-lg md:text-xl">
                    Yes
                  </label>
                </span>
                <span className="inline-flex items-center">
                  <input
                    type="radio"
                    name={this.props.ethnicity.key}
                    onChange={this.props.handleChange}
                    value={false}
                    checked={f.ethnicity === "false"}
                  />
                  <label className="ml-1 md:ml-2 text-base sm:text-lg md:text-xl">
                    No
                  </label>
                </span>
              </div>
            </div>
            <div className="flex items-center justify-between">
              <label
                className="text-base sm:text-lg md:text-xl"
                htmlFor={this.props.veteran.key}
              >
                {this.props.veteran.text}
              </label>
              <div className="flex items-center space-x-8">
                <span className="inline-flex items-center">
                  <input
                    type="radio"
                    name={this.props.veteran.key}
                    onChange={this.props.handleChange}
                    value={true}
                    checked={f.veteran === "true"}
                  />
                  <label className="ml-1 md:ml-2 text-base sm:text-lg md:text-xl">
                    Yes
                  </label>
                </span>
                <span className="inline-flex items-center">
                  <input
                    type="radio"
                    name={this.props.veteran.key}
                    onChange={this.props.handleChange}
                    value={false}
                    checked={f.veteran === "false"}
                  />
                  <label className="ml-1 md:ml-2 text-base sm:text-lg md:text-xl">
                    No
                  </label>
                </span>
              </div>
            </div>
            <div className="flex items-center justify-between">
              <label
                className="text-base sm:text-lg md:text-xl"
                htmlFor={this.props.disabling_condition.key}
              >
                {this.props.disabling_condition.text}
              </label>
              <div className="flex items-center space-x-8">
                <span className="inline-flex items-center">
                  <input
                    type="radio"
                    name={this.props.disabling_condition.key}
                    onChange={this.props.handleChange}
                    value={true}
                    checked={f.disabling_condition === "true"}
                  />
                  <label className="ml-1 md:ml-2 text-base sm:text-lg md:text-xl">
                    Yes
                  </label>
                </span>
                <span className="inline-flex items-center">
                  <input
                    type="radio"
                    name={this.props.disabling_condition.key}
                    onChange={this.props.handleChange}
                    value={false}
                    checked={f.disabling_condition === "false"}
                  />
                  <label className="ml-1 md:ml-2 text-base sm:text-lg md:text-xl">
                    No
                  </label>
                </span>
              </div>
            </div>
          </div>
        </div>
        <div className="mt-3 p-4 flex items-center justify-center bg-gray-50 border-t border-gray-200">
          <button
            type="button"
            className="flex items-center space-x-2 px-2 sm:px-4 py-1 sm:py-2 border border-gray-400 rounded shadow"
            onClick={this.props.remove}
          >
            <span className="text-red-500">
              <BsTrash className="w-4 h-4 sm:w-5 sm:h-5 md:w-6 md:h-6" />
            </span>
            <span className="text-sm sm:text-base md:text-lg">Delete</span>
          </button>
          <button
            type="button"
            className="flex items-center space-x-2 ml-2 sm:ml-4 px-2 sm:px-4 py-1 sm:py-2 bg-indigo-500 border border-indigo-400 text-white font-semibold tracking-wide rounded shadow"
            onClick={this.props.save}
          >
            <span className="text-white">
              <HiOutlineSaveAs className="w-4 h-4 sm:w-5 sm:h-5 md:w-6 md:h-6" />
            </span>
            <span className="text-sm sm:text-base md:text-lg">
              Save Family Member
            </span>
          </button>
        </div>
      </div>
    );
  }
}
export default FamilyMemberForm;
