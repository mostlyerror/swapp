import React, { Component } from 'react'
import { Dialog, Transition } from '@headlessui/react'

class ModalTransition extends Component {
  render() {
    return (
      <Transition
        appear={this.props.appear}
        enter="transition-opacity duration-200"
        enterFrom="opacity-0"
        enterTo="opacity-100"
        leave="transition-opacity duration-150"
        leaveFrom="opacity-100"
        leaveTo="opacity-0"
        show={this.props.show}>
        {this.props.children}
      </Transition>
    )
  }

}
class Proceed extends Component {
  render() {
    return <p>Proceeding with intake...</p>
  }
}

class DoNotProceed extends Component {
  render() {
    return (
      <div>
        <p>Vouchers may only be issued to clients that will be unsheltered tonight.</p>
        <div className="mt-4 sm:mt-6 md:mt-8 flex items-center gap-2 sm:gap-3 md:gap-4">
          <button
            className="flex-1 text-base text-center px-4 py-2 border
                border-gray-300 shadow-sm text-xs sm:text-base md:text-lg font-medium rounded
                text-gray-700 bg-white hover:bg-gray-50 focus:outline-none
                focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
            onClick={() => {
              setTimeout(() => { history.go(-1) }, 400)
            }}
          >
            Ok, go back.
          </button>
        </div>
      </div>
    )
  }
}

class UnshelteredHomelessnessQuestion extends Component {
  render() {
    return (
      <div>
        <Dialog.Description className="text-base sm:text-lg md:text-xl text-gray-700">
          Are you experiencing unsheltered homelessness or will you be
          unsheltered tonight if you do not receive a hotel voucher?
          Unsheltered homelessness is sleeping outside, in a tent, or in
          a vehicle including an RV.
        </Dialog.Description>
        <div className="flex flex-col space-between gap-2 sm:gap-4 md:gap-6">
          <div className="mt-4 sm:mt-6 md:mt-8 flex items-center gap-2 sm:gap-3 md:gap-4">
            <button
              className="flex-1 text-base text-center px-4 py-2 border
                   border-gray-300 shadow-sm text-xs sm:text-base md:text-lg font-medium rounded
                   text-gray-700 bg-white hover:bg-gray-50 focus:outline-none
                   focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
              onClick={this.props.onYes}
            >
              Yes
            </button>

            <button
              className="flex-1 text-base text-center px-4 py-2 border
                   border-gray-300 shadow-sm text-xs sm:text-base md:text-lg font-medium rounded
                   text-gray-700 bg-white hover:bg-gray-50 focus:outline-none
                   focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
              onClick={this.props.onNo}
            >
              No
            </button>
          </div>
        </div>
      </div>
    )
  }
}

class UnshelteredHomelessnessVerification extends Component {
  state = {
    showModal: true,
    answered: false,
    canProceed: false,
  }

  handleYes = () => {
    this.setState({ answered: true, canProceed: true })
    setTimeout(() => {
      this.closeModal()
    }, 1600)
  }

  handleNo = () => { this.setState({ answered: true, canProceed: false }) }

  closeModal = () => { this.setState({ showModal: false }) }

  render() {
    return (
      <div>
        <Dialog open={this.state.showModal} onClose={() => { }} className="fixed z-10 inset-0 overflow-y-auto">
          <div className="p-2 sm:p-1 flex items-center justify-center min-h-screen">
            <Dialog.Overlay className="fixed inset-0 bg-black opacity-40" />
            <div className="p-2 sm:p-4 md:p-6 z-10 bg-white rounded max-w-3xl mx-auto">
              <Dialog.Title className="text-lg sm:text-xl md:text-2xl font-bold">
                Unsheltered Homelessness Verification
              </Dialog.Title>
              <div className="text-xl pt-6">
                {/* TODO: wrap these using Transition.Child to coordinate
                multiple transitions and solve for UI jitter */}
                <ModalTransition appear={true} show={!this.state.answered}>
                  <UnshelteredHomelessnessQuestion onYes={this.handleYes} onNo={this.handleNo}/>
                </ModalTransition>
                <ModalTransition show={this.state.answered && this.state.canProceed}>
                  <Proceed />
                </ModalTransition>
                <ModalTransition show={this.state.answered && !this.state.canProceed}>
                  <DoNotProceed />
                </ModalTransition>
              </div>
            </div>
          </div>
        </Dialog>
      </div >
    )
  }
}

export default UnshelteredHomelessnessVerification