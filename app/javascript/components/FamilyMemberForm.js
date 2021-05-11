import React, { Component } from "react";
import { BsTrash } from "react-icons/bs";
import { HiOutlineSaveAs } from "react-icons/hi";

const inputName = (id, fieldName) =>
  `short_intake[family_members][${id}][${fieldName}]`;

class FamilyMemberForm extends Component {
  render() {
    return (
      <div className="flex flex-col text-sm bg-white rounded-md shadow">
        <div className="p-2 sm:p-3 space-y-3 sm:space-y-4">
          <div>
            <label
              className="block text-xs sm:text-sm"
              htmlFor={this.props.first_name.key}
            >
              {this.props.first_name.text}
            </label>
            <input
              type="text"
              name={this.props.first_name.key}
              className="w-full text-sm border border-gray-200 rounded-sm"
              onChange={this.props.handleChange}
              value={this.props.familyMember.first_name}
              autoFocus
            />
          </div>
          <div>
            <label
              className="block text-xs sm:text-sm"
              htmlFor={this.props.last_name.key}
            >
              {this.props.last_name.text}
            </label>
            <input
              type="text"
              name={this.props.last_name.key}
              className="w-full text-sm border border-gray-200 rounded-sm"
              onChange={this.props.handleChange}
              value={this.props.familyMember.last_name}
            />
          </div>
          <div>
            <label
              className="block text-xs sm:text-sm"
              htmlFor={this.props.relationship.key}
            >
              {this.props.relationship.text}
            </label>
            <input
              type="text"
              name={this.props.relationship.key}
              className="w-full text-sm border border-gray-200 rounded-sm"
              onChange={this.props.handleChange}
              value={this.props.familyMember.relationship}
            />
          </div>
          <div>
            <label
              className="block text-xs sm:text-sm"
              htmlFor={this.props.date_of_birth.key}
            >
              {this.props.date_of_birth.text}
            </label>
            <input
              type="date"
              name={this.props.date_of_birth.key}
              className="w-full text-sm border border-gray-200 rounded-sm"
              onChange={this.props.handleChange}
              value={this.props.familyMember.date_of_birth}
            />
          </div>
          <div>
            <label
              className="block text-xs sm:text-sm"
              htmlFor={this.props.race.key}
            >
              {this.props.race.text}
            </label>
            <select
              className="w-full text-sm border border-gray-200 rounded-sm"
              name={this.props.race.key}
              onChange={this.props.handleChange}
              value={this.props.familyMember.race}
            >
              {this.props.race.choices.map((choice, idx) => (
                <option key={idx}>{choice}</option>
              ))}
            </select>
          </div>
          <div className="mt-2 p-1 space-y-4 text-sm">
            <div className="flex items-center justify-between">
              <label htmlFor={this.props.ethnicity.key}>
                {this.props.ethnicity.text}
              </label>
              <div className="flex items-center space-x-8">
                <span>
                  <input
                    type="radio"
                    name={this.props.ethnicity.key}
                    onChange={this.props.handleChange}
                    value={true}
                  />
                  <label className="ml-1">Yes</label>
                </span>
                <span>
                  <input
                    type="radio"
                    name={this.props.ethnicity.key}
                    onChange={this.props.handleChange}
                    value={false}
                  />
                  <label className="ml-1">No</label>
                </span>
              </div>
            </div>
            <div className="flex items-center justify-between">
              <label htmlFor={this.props.veteran.key}>
                {this.props.veteran.text}
              </label>
              <div className="flex items-center space-x-8">
                <span>
                  <input
                    type="radio"
                    name={this.props.veteran.key}
                    onChange={this.props.handleChange}
                    value={true}
                  />
                  <label className="ml-1">Yes</label>
                </span>
                <span>
                  <input
                    type="radio"
                    name={this.props.veteran.key}
                    onChange={this.props.handleChange}
                    value={false}
                  />
                  <label className="ml-1">No</label>
                </span>
              </div>
            </div>
            <div className="flex items-center justify-between">
              <label htmlFor={this.props.disabling_condition.key}>
                {this.props.disabling_condition.text}
              </label>
              <div className="flex items-center space-x-8">
                <span>
                  <input
                    type="radio"
                    name={this.props.disabling_condition.key}
                    onChange={this.props.handleChange}
                    value={true}
                  />
                  <label className="ml-1">Yes</label>
                </span>
                <span>
                  <input
                    type="radio"
                    name={this.props.disabling_condition.key}
                    onChange={this.props.handleChange}
                    value={false}
                  />
                  <label className="ml-1">No</label>
                </span>
              </div>
            </div>
          </div>
        </div>
        <div className="mt-3 p-4 flex items-center justify-center bg-gray-50 border-t border-gray-200 text-sm">
          <button
            type="button"
            className="flex items-center space-x-2 px-2 sm:px-4 py-1 sm:py-2 border border-gray-400 rounded shadow"
            onClick={this.props.remove}
          >
            <span className="text-red-500">
              <BsTrash className="w-3 h-3" />
            </span>
            <span>Delete</span>
          </button>
          <button
            type="button"
            className="flex items-center space-x-2 ml-2 sm:ml-4 px-2 sm:px-4 py-1 sm:py-2 bg-indigo-500 border border-indigo-400 text-white font-semibold tracking-wide rounded shadow"
            onClick={this.props.save}
          >
            <span className="text-white">
              <HiOutlineSaveAs className="w-4 h-4" />
            </span>
            <span>Save Family Member</span>
          </button>
        </div>
      </div>
    );
  }
}
export default FamilyMemberForm;
