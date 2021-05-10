import React, { Component } from "react";

class FamilyMemberForm extends Component {
  render() {
    return (
      <div>
        <div>
          <label htmlFor="firstName">First Name</label>
          <input
            type="text"
            name="firstName"
            onChange={this.props.handleChange}
            value={this.props.familyMember.firstName}
            autoFocus
          />
        </div>
        <div>
          <label htmlFor="lastName">Last Name</label>
          <input
            type="text"
            name="lastName"
            onChange={this.props.handleChange}
            value={this.props.familyMember.lastName}
          />
        </div>
        <div>
          <label htmlFor="relationship">Relationship</label>
          <input
            type="text"
            name="relationship"
            onChange={this.props.handleChange}
            value={this.props.familyMember.relationship}
          />
        </div>
        <div>
          <label htmlFor="dateOfBirth">Date of Birth</label>
          <input
            type="date"
            name="dateOfBirth"
            onChange={this.props.handleChange}
            value={this.props.familyMember.dateOfBirth}
          />
        </div>
        <div>
          <button
            type="button"
            className=""
            onClick={(event) => this.props.remove(this.props.familyMember.id)}
          >
            Remove
          </button>
          <button type="button" className="" onClick={this.props.save}>
            Save
          </button>
        </div>
      </div>
    );
  }
}
export default FamilyMemberForm;
