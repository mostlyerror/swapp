import React from 'react'
import Button from './Button'

// first empty state
export function Step1(props) {
  return (
    <>
      <img src="https://i.imgur.com/NNJS2hi.png"></img>
      <Button onClick={props.advance}>Create new SWAP Period</Button>
    </>
  )
}
