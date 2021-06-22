import React from 'react'

const Button = (props) => {
  return (
    <button
      className="px-4 py-2 
      rounded-lg border border-black shadow-xl
      bg-admin-blue hover:bg-admin-blue-700 
      text-black text-xl"
      type="button"
      onClick={props.onClick}
      {...props}
    >
      {props.children}
    </button>
  )
}

export default Button
