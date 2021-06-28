import React from 'react'

const ButtonOutline = (props) => {
  return (
    <button
      className="px-6 py-4 
      rounded-xl border border-gray-800 hover:bg-grey-50
      text-gray-900"
      type="button"
      onClick={props.onClick}
      {...props}
    >
      {props.children}
    </button>
  )
}

export default ButtonOutline
