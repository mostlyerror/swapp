import React, { Component } from "react";
import { Switch } from "@headlessui/react";

function classNames(...classes) {
  return classes.filter(Boolean).join(" ");
}

class Toggle extends Component {
  constructor(props) {
    super(props);
  }

  state = {
    namePrefix: "intake",
    isEnabled: false,
  };

  setEnabled = (event) => {
    this.setState((prevState) => ({ isEnabled: !prevState.isEnabled }));
  };

  render() {
    return (
      <div>
        <label
          htmlFor={`${this.state.namePrefix}[${this.props.question.key}]`}
          className="pl-1 block text-sm font-medium"
        >
          {this.props.question.text}
        </label>
        <Switch
          checked={this.state.isEnabled}
          onChange={this.setEnabled}
          className={classNames(
            this.state.isEnabled ? "bg-indigo-600" : "bg-gray-200",
            "mt-2 relative inline-flex flex-shrink-0 h-10 w-full border border-transparent rounded cursor-pointer transition-colors ease-in-out duration-200 focus:outline-none focus:ring-2 focus:ring-offset-0 focus:ring-indigo-500"
          )}
        >
          <input
            type="radio"
            className="hidden"
            readOnly
            checked={this.state.isEnabled}
            value={this.state.isEnabled}
            name={this.props.name}
          />
          <span className="sr-only">{`toggle for question: ${this.props.question.text}`}</span>
          <span
            aria-hidden="true"
            className={classNames(
              this.state.isEnabled ? "translate-x-full" : "translate-x-0",
              "pointer-events-none inline-block h-full w-1/2 rounded bg-white shadow transform ring-0 transition ease-in-out duration-100"
            )}
          >
            <span
              className={classNames(
                this.state.isEnabled
                  ? "opacity-0 ease-out duration-100"
                  : "opacity-100 ease-in duration-200",
                "absolute -inset-1 flex items-center justify-center transition-opacity"
              )}
              aria-hidden="true"
            >
              No
            </span>
            <span
              className={classNames(
                this.state.isEnabled
                  ? "opacity-100 ease-in duration-200"
                  : "opacity-0 ease-out duration-100",
                "absolute inset-0 flex items-center justify-center transition-opacity"
              )}
              aria-hidden="true"
            >
              Yes
            </span>
          </span>
        </Switch>
        {this.state.isEnabled && this.props.children}
      </div>
    );
  }
}

export default Toggle;
