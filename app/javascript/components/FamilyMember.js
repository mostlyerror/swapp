import React from "react";

// this is a bit of a hack since React doesn't control the full form submission.
// we instead stick a bunch of hidden input nodes in the DOM
const inputName = (id, fieldName) =>
  `intake[client_attributes][family_members][${id}][${fieldName}]`;

const FamilyMember = (props) => {
  let f = props.familyMember;
  return (
    <div className="flex items-center justify-between p-2 grid grid-cols-10">
      <input
        readOnly
        className="hidden"
        name={inputName(f.id, "first_name")}
        value={f.first_name}
      />
      <input
        readOnly
        className="hidden"
        name={inputName(f.id, "last_name")}
        value={f.last_name}
      />
      <input
        readOnly
        className="hidden"
        name={inputName(f.id, "relationship")}
        value={f.relationship}
      />
      <input
        readOnly
        className="hidden"
        name={inputName(f.id, "date_of_birth")}
        value={f.date_of_birth}
      />
      <input
        readOnly
        className="hidden"
        name={inputName(f.id, "gender")}
        value={f.gender}
      />
      <input
        readOnly
        className="hidden"
        name={inputName(f.id, "race")}
        value={f.race}
      />
      <input
        readOnly
        className="hidden"
        name={inputName(f.id, "ethnicity")}
        value={f.ethnicity}
      />
      <input
        readOnly
        className="hidden"
        name={inputName(f.id, "veteran")}
        value={f.veteran}
      />
      <input
        readOnly
        className="hidden"
        name={inputName(f.id, "disabling_condition")}
        value={f.disabling_condition}
      />

      <span className="col-span-5 font-semibold">{`${f.first_name} ${f.last_name}`}</span>
      <span className="col-span-4">{f.relationship}</span>
      <button
        type="button"
        className="colspan-1 text-indigo-500"
        onClick={(e) => props.onEdit(f.id)}
      >
        edit
      </button>
    </div>
  );
};

export default FamilyMember;
