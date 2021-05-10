import React, { Component } from "react";
import { MdClose } from "react-icons/md";
import { FiEdit3 } from "react-icons/fi";

import FamilyMemberForm from "./FamilyMemberForm";
import FamilyMember from "./FamilyMember";

const createFamilyMember = (id) => {
  return {
    id: id,
    firstName: "",
    lastName: "",
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

  cancel = (event) => {
    this.setState({
      currentFamilyMember: null,
    });
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
      <div className="text-sm">
        <p>Family Members</p>
        <ul>
          {this.state.family.map((f, idx) => (
            <li className="bg-white rounded shadow" key={f.id}>
              <FamilyMember familyMember={f} onEdit={this.handleEdit} />
            </li>
          ))}
        </ul>

        {this.state.currentFamilyMember && (
          <FamilyMemberForm
            familyMember={this.state.currentFamilyMember}
            handleChange={this.handleChange}
            cancel={this.cancel}
            save={this.save}
          />
        )}

        <button type="button" className="" onClick={this.addNewFamilyMember}>
          + add family member
        </button>
      </div>
    );
  }
}

export default FamilyMembers;
