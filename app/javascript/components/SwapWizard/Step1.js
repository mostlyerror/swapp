import React from 'react'

export function Step1(props) {
  if (props.currentStep !== 1) {
    return null
  }
  return (
    <>
      <img src="https://i.imgur.com/NNJS2hi.png"></img>
    </>
  )
}
