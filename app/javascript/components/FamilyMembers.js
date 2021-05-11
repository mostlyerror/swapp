import React, { Component } from "react";
import FamilyMemberForm from "./FamilyMemberForm";
import FamilyMember from "./FamilyMember";

const createFamilyMember = (id) => {
  return {
    id: id,
    first_name: "",
    last_name: "",
    relationship: "",
    date_of_birth: "",
    ethnicity: "",
    veteran: "",
    disabling_condition: "",
  };
};

class FamilyMembers extends Component {
  state = {
    sequence: 0,
    family: [],
    currentFamilyMember: null,
  };

  addNewFamilyMember = () => {
    this.setState((prevState) => {
      return {
        sequence: prevState.sequence + 1,
        currentFamilyMember: createFamilyMember(prevState.sequence),
      };
    });
  };

  handleChange = (event) => {
    this.setState((prevState) => {
      let f = prevState.currentFamilyMember;
      f[event.target.name] = event.target.value;
      return {
        currentFamilyMember: f,
      };
    });
  };

  handleEdit = (id) => {
    console.log(`editing fam:${id}`);
    this.setState({
      currentFamilyMember: this.state.family.find((f) => f.id === id),
    });
  };

  remove = () => {
    this.setState((prevState) => ({
      family: prevState.family.filter(
        (f) => f.id !== this.state.currentFamilyMember.id
      ),
      currentFamilyMember: null,
    }));
  };

  save = (event) => {
    // todo don't allow save without firstName, lastnName, dob, relationship
    this.setState((prevState) => {
      if (
        prevState.family.find((f) => f.id === this.state.currentFamilyMember.id)
      ) {
        return {
          currentFamilyMember: null,
        };
      }
      return {
        family: [...prevState.family, this.state.currentFamilyMember],
        currentFamilyMember: null,
      };
    });
  };

  render() {
    return (
      <div className="text-sm space-y-3">
        <p className="text-lg text-center sm:text-left font-semibold tracking-wide">
          Family Members
        </p>
        <ul className="mt-2 bg-white rounded shadow">
          {this.state.family.map((f, idx) => (
            <FamilyMember
              key={f.id}
              familyMember={f}
              onEdit={this.handleEdit}
            />
          ))}
        </ul>

        {this.state.currentFamilyMember && (
          <FamilyMemberForm
            {...this.props.sub_questions}
            familyMember={this.state.currentFamilyMember}
            handleChange={this.handleChange}
            remove={this.remove}
            save={this.save}
          />
        )}

        {!this.state.currentFamilyMember && (
          <div className="text-center">
            <button
              type="button"
              className="px-2 py-1 bg-white hover:bg-gray-50 rounded shadow border border-indigo-600
              focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
              onClick={this.addNewFamilyMember}
            >
              + add family member
            </button>
          </div>
        )}
      </div>
    );
  }
}

export default FamilyMembers;
