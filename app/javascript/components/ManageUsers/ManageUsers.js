import React, { useState } from 'react'
import axios from 'axios'
import List from './List'

const ManageUsers = (props) => {
  const [users, setUsers] = useState(props.users)
  const [term, setTerm] = useState('')
  const [errors, setErrors] = useState([])

  const handleSearchChange = (event) => {
    setTerm(event.target.value.toLowerCase())
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

  const resetUsers = () => setUsers(props.users)

  return (
    <main className="container mx-auto lg:max-w-7xl">
      <h1 className="font-bold">Manage Users</h1>
      <div className="mt-8 flex justify-between">
        <input
          className="w-2/3 rounded-lg border border-gray-400 text-base px-4 py-2"
          type="search"
          placeholder="Search by first or last name"
          autoFocus="autofocus"
          value={term}
          onChange={handleSearchChange}
        />
      </div>
      <div className="mt-8">
        <List
          setUsers={setUsers}
          resetUsers={resetUsers}
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
