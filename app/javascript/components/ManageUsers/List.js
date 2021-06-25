import React, { useState } from 'react'

const UserEditRow = (props) => {
  return (
    <tr>
      <td className="px-6 py-4 whitespace-nowrap">
        <div className="flex items-start">
          <div className="flex-shrink-0 h-10 w-10">
            <span className="mt-1 inline-flex items-center justify-center h-10 w-10 rounded-full bg-gray-500">
              <span className="text-sm md:text-base font-medium leading-none text-white">
                {`${props.person.first_name[0]}${props.person.last_name[0]}`}
              </span>
            </span>
          </div>
          <div className="ml-4 space-y-2">
            <div className="flex gap-2 text-sm font-medium text-gray-900">
              <div className="flex flex-col">
                <label className="text-xs uppercase tracking-wide font-semibold text-gray-500">
                  First Name
                </label>
                <input
                  className="p-1 rounded text-sm text-gray-800"
                  type="text"
                  defaultValue={props.person.first_name}
                />
              </div>
              <div className="flex flex-col">
                <label className="text-xs uppercase tracking-wide font-semibold text-gray-500">
                  Last Name
                </label>
                <input
                  className="p-1 rounded text-sm text-gray-800"
                  type="text"
                  defaultValue={props.person.last_name}
                />
              </div>
            </div>
            <div className="flex flex-col">
              <label className="text-xs uppercase tracking-wide font-semibold text-gray-500">
                Email
              </label>
              <input
                className="p-1 rounded text-sm text-gray-800"
                type="text"
                defaultValue={props.person.email}
              />
            </div>
          </div>
        </div>
      </td>
      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 flex items-start gap-2">
        <div>
          <p className="text-xs uppercase tracking-wide font-semibold text-gray-500">
            Roles
          </p>

          <div className="p-1">
            <div>
              <input
                className="w-4 h-4"
                type="checkbox"
                defaultChecked={props.person.roles.includes('intake')}
              />
              <label className="ml-2 text-base">Intake</label>
            </div>
            <div>
              <input
                className="w-4 h-4"
                type="checkbox"
                defaultChecked={props.person.roles.includes('admin')}
              />
              <label className="ml-2 text-base">Admin</label>
            </div>
            <div>
              <input
                className="w-4 h-4"
                type="checkbox"
                defaultChecked={props.person.roles.includes('hotel')}
              />
              <label className="ml-2 text-base">Hotel</label>
            </div>
          </div>
        </div>

        {/* {props.person.roles.map((role, roleIdx) => {
          return (
            <span
              key={roleIdx}
              className="px-2 py-1 bg-indigo-50 text-black text-sm rounded"
            >
              {role}
            </span>
          )
        })} */}
      </td>
      <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
        <button
          type="button"
          className="text-indigo-600 hover:text-indigo-900"
          onClick={() => props.onEdit(props.person.id)}
        >
          Save
        </button>
      </td>
    </tr>
  )
}

const UserRow = (props) => {
  return (
    <tr>
      <td className="px-6 py-4 whitespace-nowrap">
        <div className="flex items-center">
          <div className="flex-shrink-0 h-10 w-10">
            <span className="inline-flex items-center justify-center h-10 w-10 rounded-full bg-gray-500">
              <span className="text-sm md:text-base font-medium leading-none text-white">
                {`${props.person.first_name[0]}${props.person.last_name[0]}`}
              </span>
            </span>
          </div>
          <div className="ml-4">
            <div className="text-sm font-medium text-gray-900">
              {`${props.person.first_name} ${props.person.last_name}`}
            </div>
            <div className="text-sm text-gray-500">{props.person.email}</div>
          </div>
        </div>
      </td>
      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 space-x-2">
        {props.person.roles.map((role, roleIdx) => {
          return (
            <span
              key={roleIdx}
              className="px-2 py-1 bg-indigo-50 text-black text-sm rounded"
            >
              {role}
            </span>
          )
        })}
      </td>
      <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
        <button
          type="button"
          className="text-indigo-600 hover:text-indigo-900"
          onClick={() => props.onEdit(props.person.id)}
        >
          Edit
        </button>
      </td>
    </tr>
  )
}

const List = (props) => {
  const [editing, setEditing] = useState(null)

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
