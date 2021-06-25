import React, { useState } from 'react'
import UserRow from './UserRow'
import UserEditRow from './UserEditRow'

const List = (props) => {
  // const [editing, setEditing] = useState(null)
  const [editing, setEditing] = useState(1)

  const handleEdit = (id) => {
    console.log(`editing user: ${id}`)
    setEditing(id)
  }

  return (
    <div className="flex flex-col">
      <div className="border border-gray-800 rounded-lg p-1">
        <div className="overflow-y-scroll max-h-128">
          <div className="align-middle inline-block min-w-full">
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-50">
                <tr>
                  <th
                    scope="col"
                    className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                  >
                    User
                  </th>
                  <th
                    scope="col"
                    className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                  >
                    Roles
                  </th>
                  <th scope="col" className="relative px-6 py-3">
                    <span className="sr-only">Edit</span>
                  </th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {props.users.map((person) =>
                  person.id === editing ? (
                    <UserEditRow key={person.email} person={person} />
                  ) : (
                    <UserRow
                      onEdit={handleEdit}
                      key={person.email}
                      person={person}
                    />
                  )
                )}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  )
}

export default List
