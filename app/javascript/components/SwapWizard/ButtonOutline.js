import React from 'react'

const ButtonOutline = (props) => {
  return (
    <button
      className="px-4 py-2 rounded-md border border-gray-700 hover:bg-grey-50 text-gray-900"
      type="button"
      onClick={props.onClick}
      {...props}
    >
      {props.children}
    </button>
  )
}

export default ButtonOutline
