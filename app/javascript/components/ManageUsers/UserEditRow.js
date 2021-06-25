import React from 'react'

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
              <div className="flex flex-col p-1">
                <label className="text-xs uppercase tracking-wide font-semibold text-gray-500">
                  First Name
                </label>
                <input
                  className="p-1 rounded text-sm text-gray-800 border-gray-300"
                  type="text"
                  defaultValue={props.person.first_name}
                />
              </div>
              <div className="flex flex-col p-1">
                <label className="text-xs uppercase tracking-wide font-semibold text-gray-500">
                  Last Name
                </label>
                <input
                  className="p-1 rounded text-sm text-gray-800 border-gray-300"
                  type="text"
                  defaultValue={props.person.last_name}
                />
              </div>
            </div>
            <div className="flex flex-col p-1">
              <label className="text-xs uppercase tracking-wide font-semibold text-gray-500">
                Email
              </label>
              <input
                className="p-1 rounded text-sm text-gray-800 border-gray-300"
                type="text"
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
            <div className="flex items-center">
              <input
                className={`w-4 h-4 rounded admin-blue
                border-2 border-gray-300 focus:border-indigo-500
                focus:ring-indigo-200 focus:ring-offset-0 focus:ring-3
                ${props.person.roles.includes('intake') && 'font-bold'} `}
                type="checkbox"
                defaultChecked={props.person.roles.includes('intake')}
              />
              <label
                className={`ml-2 text-base ${
                  props.person.roles.includes('intake') && 'font-bold'
                }

              }`}
              >
                Intake
              </label>
            </div>
            <div className="flex items-center">
              <input
                className={`w-4 h-4 rounded admin-blue
                border-2 border-gray-300 focus:border-indigo-500
                focus:ring-indigo-200 focus:ring-offset-0 focus:ring-3
                ${props.person.roles.includes('admin') && 'font-bold'} `}
                type="checkbox"
                defaultChecked={props.person.roles.includes('admin')}
              />
              <label
                className={`ml-2 text-base ${
                  props.person.roles.includes('admin') && 'font-bold'
                }

              }`}
              >
                Admin
              </label>
            </div>
            <div className="flex items-center">
              <input
                className={`w-4 h-4 rounded admin-blue
                border-2 border-gray-300 focus:border-indigo-500
                focus:ring-indigo-200 focus:ring-offset-0 focus:ring-3`}
                type="checkbox"
                defaultChecked={props.person.roles.includes('hotel')}
              />
              <label
                className={`ml-2 text-base ${
                  props.person.roles.includes('hotel') && 'font-bold'
                }

              }`}
              >
                Hotel
              </label>
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

export default UserEditRow
