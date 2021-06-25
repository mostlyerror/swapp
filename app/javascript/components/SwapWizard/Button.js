import React from 'react'

const Button = (props) => {
  return (
    <button
      className="px-6 py-4 
      rounded-xl border border-black shadow-xl
      bg-admin-blue hover:bg-admin-blue-700"
      type="button"
      onClick={props.onClick}
      {...props}
    >
      {props.children}
    </button>
  )
}

export default Button
