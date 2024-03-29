import React, { Component } from "react";
import Toggle from "./Toggle";
import { classNames } from "./utils";

class IncomeSourceToggle extends Component {
  render() {
    return (
      <Toggle question={this.props.question} name={this.props.name}>
        <div
          id="income_source_container"
          className="bg-white rounded shadow mt-1 sm:mt-2 md:mt-3 p-2 sm:p-3 md:p-4"
        >
          <div className="grid grid-cols-10 gap-1 p-1 text-sm sm:text-base md:text-lg font-semibold flex items-center">
            <span className="col-span-6">Income Source</span>
            <span className="col-span-4 text-center">
              Approx
              <span className="block sm:inline"> Mthly $</span>
            </span>
          </div>
          <div className="mt-1">
            {Object.entries(this.props.question.sub_choices).map(
              (pair, idx) => {
                let name = `intake[${pair[0]}]`;
                let displayName = pair[1];

                return (
                  <div
                    key={idx}
                    className={classNames(
                      idx % 2 == 0 ? "bg-gray-50" : "bg-gray-100",
                      "grid grid-cols-10 p-2 sm:p-3 md:p-4",
                      "flex items-center"
                    )}
                  >
                    <label
                      className="col-span-7 items-start text-sm sm:text-base md:text-lg"
                      htmlFor={name}
                    >
                      {displayName}
                    </label>
                    <input
                      type="number"
                      name={name}
                      className="col-span-3 w-full tabular-nums border border-gray-300 text-sm sm:text-base md:text-lg"
                      required={false}
                    />
                  </div>
                );
              }
            )}
          </div>
        </div>
      </Toggle>
    );
  }
}

export default IncomeSourceToggle;
