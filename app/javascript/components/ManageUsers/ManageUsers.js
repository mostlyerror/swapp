import React, { useState } from 'react'
import axios from 'axios'
import List from './List'

// const Filters = (props) => {
//   return (
//     <ul className="flex flex-1">
//       <li>Active</li>
//     </ul>
//   )
// }

const ManageUsers = (props) => {
  const [users, setUsers] = useState(props.users)
  const [term, setTerm] = useState('')
  const [errors, setErrors] = useState([])

  const handleSearchChange = (event) => {
    setTerm(event.target.value.toLowerCase())
    // filter the user list
  }

  const handleUpdateUser = (person) => {
    const updateUserURL = `/admin/users/${person.id}`
    axios
      .put(updateUserURL, person)
      .then((response) => {
        window.location.reload()
      })
      .catch((err) => {
        setErrors(err.response.data)
      })
  }

  return (
    <main className="container mx-auto lg:max-w-7xl">
      <h1 className="font-bold">Manage Users</h1>
      <div className="mt-8 flex gap-4">
        <input
          className="flex-1 rounded-lg border border-gray-400 text-base px-4 py-2"
          type="search"
          placeholder="Search by first or last name"
          autoFocus="autofocus"
          value={term}
          onChange={handleSearchChange}
        />
        {/* <Filters /> */}
      </div>
      <div className="mt-8">
        <List
          setUsers={setUsers}
          users={users.filter((user) => {
            return (
              user.first_name.toLowerCase().match(term) ||
              user.last_name.toLowerCase().match(term) ||
              user.email.toLowerCase().match(term)
            )
          })}
          handleUpdateUser={handleUpdateUser}
        />
      </div>
    </main>
  )
}

export default ManageUsers
