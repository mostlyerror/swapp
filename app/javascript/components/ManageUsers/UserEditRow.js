import React, { useState } from 'react'

const UserEditRow = (props) => {
  const [person, setPerson] = useState(props.person)

  const handleChange = (event) => {
    if (event.target.name.match('roles')) {
      let role = event.target.name.match(/roles\[(\w+)\]/)[1]

      setPerson({
        ...person,
        roles: person.roles.includes(role)
          ? person.roles.filter((r) => r !== role)
          : person.roles.concat([role]),
      })
    } else if (event.target.name.match('active')) {
      setPerson({
        ...person,
        active: !person.active,
      })
    } else {
      setPerson({
        ...person,
        [event.target.name]: event.target.value,
      })
    }
  }

  return (
    <>
      <tr>
        <td className="px-6 py-4 whitespace-nowrap">
          <div className="flex items-start">
            <div className="flex-shrink-0 h-10 w-10">
              <span className="mt-1 inline-flex items-center justify-center h-10 w-10 rounded-full bg-gray-500">
                <span className="text-sm md:text-base font-medium leading-none text-white">
                  {`${person.first_name[0]}${person.last_name[0]}`}
                </span>
              </span>
            </div>
            <div className="ml-4 space-y-2">
              <div className="flex gap-4 text-sm font-medium text-gray-900">
                <div className="flex flex-col">
                  <label className="text-xs uppercase tracking-wide font-semibold text-gray-500">
                    First Name
                  </label>
                  <input
                    className="mt-1 px-3 py-2 rounded text-base text-gray-800 border-gray-300"
                    type="text"
                    name="first_name"
                    value={person.first_name}
                    onChange={handleChange}
                  />
                </div>
                <div className="flex flex-col">
                  <label className="text-xs uppercase tracking-wide font-semibold text-gray-500">
                    Last Name
                  </label>
                  <input
                    className="mt-1 px-3 py-2 rounded text-base text-gray-800 border-gray-300"
                    type="text"
                    name="last_name"
                    onChange={handleChange}
                    value={person.last_name}
                  />
                </div>
              </div>
              <div className="flex flex-col">
                <label className="text-xs uppercase tracking-wide font-semibold text-gray-500">
                  Email
                </label>
                <input
                  className="mt-1 px-3 py-2 rounded text-base text-gray-800 border-gray-300"
                  type="text"
                  name="email"
                  onChange={handleChange}
                  value={person.email}
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
            <div className="py-2 space-y-3">
              <div className="flex items-center">
                <input
                  className="w-5 h-5 rounded admin-blue
                  border-2 border-gray-300 focus:border-indigo-500
                  focus:ring-indigo-200 focus:ring-offset-0 focus:ring-3"
                  type="checkbox"
                  name="roles[intake]"
                  onChange={handleChange}
                  checked={person.roles.includes('intake')}
                />
                <label
                  className={`ml-2 text-lg ${
                    person.roles.includes('intake') && 'font-bold'
                  }

              }`}
                >
                  Intake
                </label>
              </div>
              <div className="flex items-center">
                <input
                  className="w-5 h-5 rounded admin-blue
                  border-2 border-gray-300 focus:border-indigo-500
                  focus:ring-indigo-200 focus:ring-offset-0 focus:ring-3"
                  type="checkbox"
                  name="roles[admin]"
                  onChange={handleChange}
                  checked={person.roles.includes('admin')}
                />
                <label
                  className={`ml-2 text-lg ${
                    person.roles.includes('admin') && 'font-bold'
                  }

              }`}
                >
                  Admin
                </label>
              </div>
              <div className="flex items-center">
                <input
                  className="w-5 h-5 rounded admin-blue
                  border-2 border-gray-300 focus:border-indigo-500
                  focus:ring-indigo-200 focus:ring-offset-0 focus:ring-3"
                  type="checkbox"
                  name="roles[hotel]"
                  onChange={handleChange}
                  checked={person.roles.includes('hotel')}
                />
                <label
                  className={`ml-2 text-lg ${
                    person.roles.includes('hotel') && 'font-bold'
                  }

              }`}
                >
                  Hotel
                </label>
              </div>
            </div>
          </div>
        </td>
        <td></td>
      </tr>
      <tr>
        <td className="px-6 py-4 whitespace-nowrap">
          <div className="flex items-center">
            <input
              className="w-5 h-5 rounded admin-blue
                  border-2 border-gray-300 focus:border-indigo-500
                  focus:ring-indigo-200 focus:ring-offset-0 focus:ring-3"
              type="checkbox"
              name="active"
              onChange={handleChange}
              checked={person.active}
            />
            <label
              className={`ml-2 text-lg ${person.active && 'font-bold'}

              }`}
            >
              Active
            </label>
          </div>
        </td>
        <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
          <div className="flex gap-6">
            <button
              type="button"
              className="text-indigo-600 hover:text-indigo-900 underline"
              onClick={props.cancelEdit}
            >
              Cancel
            </button>
            <button
              type="button"
              className="px-2 py-1 bg-admin-blue hover:bg-admin-blue-darker text-black text-sm rounded border border-black"
              onClick={() => props.handleUpdateUser(person)}
            >
              Save
            </button>
          </div>
        </td>
        <td></td>
      </tr>
    </>
  )
}

export default UserEditRow
