import React from 'react'

const Button = (props) => {
  return (
    <button
      className="px-4 py-2 rounded-md bg-indigo-600 hover:bg-indigo-700 text-white text-base "
      type="button"
      onClick={props.onClick}
      {...props}
    >
      {props.children}
    </button>
  )
}

export default Button
