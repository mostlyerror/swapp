import React from "react";

const FamilyMember = (props) => {
  return (
    <div className="flex items-center justify-between p-2">
      <span>{`${props.familyMember.firstName} ${props.familyMember.lastName}`}</span>
      <button
        type="button"
        onClick={(e) => props.onEdit(props.familyMember.id)}
      >
        edit
      </button>
    </div>
  );
};

export default FamilyMember;
