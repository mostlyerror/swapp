import React, { Component } from "react";
import Toggle from "./Toggle";

function classNames(...classes) {
  return classes.filter(Boolean).join(" ");
}

class VeteranToggle extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <Toggle question={this.props.question} name={this.props.name}>
        <div className="bg-white rounded shadow p-2 sm:p-3 md:p-4 mt-2 sm:mt-3 md:mt-4">
          <div className="space-y-4">
            <div>
              <label
                className="block font-semibold text-sm sm:text-base md:text-lg"
                htmlFor={`intake_client_attributes_${this.props.sub_questions.veteran_military_branch.key}`}
              >
                {this.props.sub_questions.veteran_military_branch.text}
              </label>
              <ul className="mt-1 p-2 space-y-2">
                {this.props.sub_questions.veteran_military_branch.choices.map(
                  (choice, idx) => {
                    let id = `intake_client_attributes_${this.props.sub_questions.veteran_military_branch.key}_${choice}`;
                    return (
                      <li className="flex items-center space-x-2" key={idx}>
                        <input
                          className=""
                          type="radio"
                          defaultValue={choice}
                          name={`intake[client_attributes][${this.props.sub_questions.veteran_military_branch.key}]`}
                          id={id}
                        />
                        <label
                          className="text-sm sm:text-base md:text-lg"
                          htmlFor={id}
                        >
                          {choice}
                        </label>
                      </li>
                    );
                  }
                )}
              </ul>
            </div>
            <div>
              <label
                className="block font-semibold text-sm sm:text-base md:text-lg"
                htmlFor={`intake_client_attributes_${this.props.sub_questions.veteran_separation_year.key}`}
              >
                {this.props.sub_questions.veteran_separation_year.text}
              </label>
              <input
                className="mt-1 w-full rounded border border-gray-200"
                type="text"
                name={`intake[client_attributes][${this.props.sub_questions.veteran_separation_year.key}]`}
                id={`intake_client_attributes_${this.props.sub_questions.veteran_separation_year.key}`}
              />
            </div>
            <div>
              <label
                className="block font-semibold text-sm sm:text-base md:text-lg"
                htmlFor={`intake_client_attributes_${this.props.sub_questions.veteran_discharge_status.key}`}
              >
                {this.props.sub_questions.veteran_discharge_status.text}
              </label>
              <ul className="mt-1 p-2 space-y-2">
                {this.props.sub_questions.veteran_discharge_status.choices.map(
                  (choice, idx) => {
                    let id = `intake_client_attributes_${this.props.sub_questions.veteran_discharge_status.key}_${choice}`;
                    return (
                      <li className="flex items-center space-x-2" key={idx}>
                        <input
                          className=""
                          type="radio"
                          defaultValue={choice}
                          name={`intake[client_attributes][${this.props.sub_questions.veteran_discharge_status.key}]`}
                          id={id}
                        />
                        <label
                          className="text-sm sm:text-base md:text-lg"
                          htmlFor={id}
                        >
                          {choice}
                        </label>
                      </li>
                    );
                  }
                )}
              </ul>
            </div>
          </div>
        </div>
      </Toggle>
    );
  }
}

export default VeteranToggle;
