import React from 'react'
import { Transition } from '@headlessui/react'

class SwapWizard extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      currentStep: 1,
      stayDates: '',
      intakedates: ''
    }
  }

  handleChange = event => {
    const {name, value} = event.target
    this.setState({
      [name]: value
    })    
  }
   
  handleSubmit = event => {
    event.preventDefault()
    const { stayDates, intakeDates } = this.state
    alert(`Your registration detail: \n stayDates: ${stayDates} \n intakeDates: ${intakeDates} `)
  }
  
  _next = () => {
    let currentStep = this.state.currentStep
    currentStep = currentStep >= 4? 5: currentStep + 1
    this.setState({
      currentStep: currentStep
    })
  }
    
  _prev = () => {
    let currentStep = this.state.currentStep
    currentStep = currentStep <= 1? 1: currentStep - 1
    this.setState({
      currentStep: currentStep
    })
  }

previousButton() {
  let currentStep = this.state.currentStep;
  if(currentStep !==1){
    return (
      <button 
        className="btn btn-secondary" 
        type="button" onClick={this._prev}>
      Previous
      </button>
    )
  }
  return null;
}

nextButton(){
  let currentStep = this.state.currentStep;
  if(currentStep < 5){
    return (
      <button 
        className="btn btn-primary float-right" 
        type="button" onClick={this._next}>
      Next
      </button>        
    )
  }
  return null;
}
  
  render() {    
    return (
      <React.Fragment>
      <h1>Create SWAP Period️</h1>
      <p>Step {this.state.currentStep} </p> 

      <form onSubmit={this.handleSubmit}>
        {this.state.currentStep === 1 && (
          <Transition
            appear={true}
            show={true}
            enter="transition-opacity duration-500"
            enterFrom="opacity-0"
            enterTo="opacity-100"
            leave="transition-opacity duration-500"
            leaveFrom="opacity-100"
            leaveTo="opacity-0"
          >
            <Step1 
              currentStep={this.state.currentStep} 
              handleChange={this.handleChange}
              stayDates={this.state.stayDates}
            />
          </Transition>
        )}

        {this.state.currentStep === 2 && (
          <Transition
            appear={true}
            show={true}
            enter="transition-opacity duration-500"
            enterFrom="opacity-0"
            enterTo="opacity-100"
            leave="transition-opacity duration-500"
            leaveFrom="opacity-100"
            leaveTo="opacity-0"
          >
            <Step2 
              currentStep={this.state.currentStep} 
              handleChange={this.handleChange}
              intakeDates={this.state.intakeDates}
            />
          </Transition>

        )}

        {this.state.currentStep === 3 && (
          <Transition
            appear={true}
            show={true}
            enter="transition-opacity duration-500"
            enterFrom="opacity-0"
            enterTo="opacity-100"
            leave="transition-opacity duration-500"
            leaveFrom="opacity-100"
            leaveTo="opacity-0"
          >
            <Step3 
              currentStep={this.state.currentStep} 
              handleChange={this.handleChange}
            />
          </Transition>
        )}

        {this.state.currentStep === 4 && (
          <Transition
            appear={true}
            show={true}
            enter="transition-opacity duration-500"
            enterFrom="opacity-0"
            enterTo="opacity-100"
            leave="transition-opacity duration-500"
            leaveFrom="opacity-100"
            leaveTo="opacity-0"
          >
            <Step4 
              currentStep={this.state.currentStep} 
              handleChange={this.handleChange}
            />
          </Transition>
        )}

        {this.state.currentStep === 4 && (
          <Transition
            appear={true}
            show={true}
            enter="transition-opacity duration-500"
            enterFrom="opacity-0"
            enterTo="opacity-100"
            leave="transition-opacity duration-500"
            leaveFrom="opacity-100"
            leaveTo="opacity-0"
          >
            <Step5
              currentStep={this.state.currentStep} 
              handleChange={this.handleChange}
            />
          </Transition>
        )}

        {this.previousButton()}
        {this.nextButton()}
      </form>
      </React.Fragment>
    );
  }
}

function Step1(props) {
  if (props.currentStep !== 1) {
    return null
  } 
  return (
    <>
      <img src="https://i.imgur.com/NNJS2hi.png"></img>
    </>
  )
}

function Step2(props) {
  if (props.currentStep !== 2) {
    return null
  } 
  return(
    <>
      <label htmlFor="">What are the hotel stay dates?</label>
      <input
        className=""
        id="stayDates"
        name="stayDates"
        type="text"
        value={props.stayDates}
        onChange={props.handleChange}
        />
    </>
  );
}

function Step3(props) {
  if (props.currentStep !== 3) {
    return null
  } 
  return(
    <>
      <label htmlFor="">What days will intake be performed?</label>
      <input
        className=""
        id="intakeDates"
        name="intakeDates"
        type="text"
        value={props.intakeDates}
        onChange={props.handleChange}
        />
    </>
  );
}

function Step4(props) {
  if (props.currentStep !== 4) {
    return null
  } 
  return(
    <>
      <h2>
        On each Intake Day, you can set the voucher supply for that day:
      </h2>
      <img src="https://media.giphy.com/media/HIYW8sTRTHt1m/giphy.gif" />
    </>
  );
}

function Step5(props) {
  if (props.currentStep !== 5) {
    return null
  } 
  return(
    <React.Fragment>
    <div className="">
      <h2>
        A New SWAP Period will be created:
      </h2>
      <div>
        Check In
        May 20
      </div>
      <div>
        Check Out
        May 22
      </div>
      <div>
        Intake Dates
        May 19
        May 20
        May 21
      </div>
    </div>
    <button className="btn btn-success btn-block">Looks good, do it!</button>
    </React.Fragment>
  );
}

export default SwapWizard