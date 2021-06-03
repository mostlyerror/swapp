import React from 'react'

const ButtonOutline = (props) => {
  return (
    <button
      className="px-4 py-2 rounded-md bg-white border border-gray-700 hover:bg-grey-50 text-gray-900 text-base"
      type="button"
      onClick={props.onClick}
      {...props}
    >
      {props.children}
    </button>
  )
}

export default ButtonOutline
